# rubocop:disable LineLength
# ImportData class
class ImportData
  def initialize(day = nil)
    @day = day || Date.today.strftime('%Y%m%d')
    @boe_url = 'https://www.boe.es'
    retriev_boe_data
  end

  def retriev_boe_data
    fetch_xml
    new_diary = create_diary
    create_sections(new_diary)
  end

  def fetch_xml
    @doc = Nokogiri::XML(open("#{@boe_url}/diario_boe/xml.php?id=BOE-S-#{@day}")) do |config|
      config.strict.noblanks
      config.strict.noent
      config.strict.noerror
      config.strict.strict
      config.strict.nonet
    end
  end

  def create_diary
    date_pub        = @doc.xpath('//sumario/meta/fechaPub').first.content.titleize
    nbo             = @doc.xpath('//sumario/diario').first['nbo']
    summary_url_pdf = @boe_url + @doc.xpath('//sumario/diario/sumario_nbo/urlPdf').first.content
    new_diary = Diary.find_or_create_by(date_pub: date_pub, nbo: nbo, summary_url_pdf: summary_url_pdf)
    new_diary
  end

  def create_sections(new_diary)
    @doc.xpath("//sumario/diario[@nbo='#{new_diary.nbo}']/seccion").each do |xml_section|
      new_section = Section.find_or_create_by(name: xml_section['nombre'], number: xml_section['num'], diary_id: new_diary.id)
      create_departments(new_section, xml_section)
    end
  end

  def create_departments(new_section, xml_section)
    xml_section.css('departamento').each do |xml_department|
      new_department = Department.find_or_create_by(name: xml_department['nombre'], section_id: new_section.id)
      xml_department.children.each do |xml_department_child|
        if xml_department_child.name == 'epigrafe'
          create_epigraph(new_department, xml_department_child)
        else
          create_department_item(new_department, xml_department_child)
        end
      end
    end
  end

  def create_epigraph(new_department, xml_department)
    new_epigraph = Epigraph.find_or_create_by(name: xml_department['nombre'], department_id: new_department.id)
    xml_department.children.each do |item|
      create_epigraph_item(new_epigraph, item)
    end
  end

  def create_epigraph_item(new_epigraph, item)
    pdf_url = @boe_url + item.at_css('urlPdf').content
    Item.find_or_create_by(item_id: item['id'], title: item.at_css('titulo').content, pdf_url: pdf_url, epigraph_id: new_epigraph.id)
  end

  def create_department_item(new_department, item)
    pdf_url = @boe_url + item.at_css('urlPdf').content
    Item.find_or_create_by(item_id: item['id'], title: item.at_css('titulo').content, pdf_url: pdf_url, department_id: new_department.id)
  end
end
