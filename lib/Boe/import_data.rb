# rubocop:disable LineLength
# ImportData class
class Boe::ImportData
  def initialize(day = nil)
    @day = day || Date.today.strftime('%Y%m')
    @boe_url = 'https://www.boe.es'
    retriev_boe_data
  end

  def retriev_boe_data
    fetch_xml
    return @doc.children.first.content if @doc.children.first.name == 'error'
    Rails.logger.info "====>Fetch boe data for day: #{@day.strftime}====>"
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
    new_diary = Diary.find_or_create_by(date_pub: date_pub, nbo: nbo, pdf_url: summary_url_pdf)
    new_diary
  end

  def create_sections(new_diary)
    @doc.xpath("//sumario/diario[@nbo='#{new_diary.nbo}']/seccion").each do |xml_section|
      new_section = new_diary.sections.find_or_create_by(name: xml_section['nombre'], number: xml_section['num'])
      create_departments(new_section, xml_section)
    end
  end

  def create_departments(new_section, xml_section)
    xml_section.css('departamento').each do |xml_department|
      new_department = new_section.departments.find_or_create_by(name: xml_department['nombre'])
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
    new_epigraph = new_department.epigraphs.find_or_create_by(name: xml_department['nombre'])
    xml_department.children.each do |item|
      create_epigraph_item(new_epigraph, item)
    end
  end

  def create_epigraph_item(new_epigraph, item)
    pdf_url = @boe_url + item.at_css('urlPdf').content
    new_epigraph.items.find_or_create_by(item_id: item['id'], title: item.at_css('titulo').content, pdf_url: pdf_url)
  end

  def create_department_item(new_department, item)
    pdf_url = @boe_url + item.at_css('urlPdf').content
    new_department.items.find_or_create_by(item_id: item['id'], title: item.at_css('titulo').content, pdf_url: pdf_url)
  end
end
