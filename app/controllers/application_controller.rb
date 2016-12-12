# ApplicationController class
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :show_request_details
  before_action :set_log_level
  before_action :prepare_meta_tags, if: "request.get?"

  def prepare_meta_tags(options={})
    site_name   = "Contenido BOE indexado"
    title       = [controller_name, action_name].join(" ")
    description = "Indexacion de los contenidos diarios del Boletin Oficial del Estado. El BOE hecho facil de leer."
    image       = options[:image] || ActionController::Base.helpers.image_path('contenido-boe.png')
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[BOE, Oficial, Gaceta, Indexado],
      twitter: {
        site_name: site_name,
        site: '@ContenidoBoe',
        card: 'owner',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end

  def show_request_details
    Rails.logger.info "\t==== Route: #{params[:controller].titleize}Controller - #{params[:action]}"
    Rails.logger.info "\t\t==== HTTP_ACCEPT \t: #{request.env['HTTP_ACCEPT']}"
    Rails.logger.info "\t\t==== Content-Type \t: #{@_headers['Content-Type']}"
    Rails.logger.info "\t\t==== CONTENT_TYPE \t: #{request.env['CONTENT_TYPE']}"
    Rails.logger.info "\t\t==== HTTP_USER_AGENT \t: #{request.env['HTTP_USER_AGENT']}"
    Rails.logger.info "\t\t==== Params: #{params}"
  end

  private
  def set_log_level
    Mongoid.logger.level =
      if Rails.env.production?
        0
      else
        1
      end
  end
end
