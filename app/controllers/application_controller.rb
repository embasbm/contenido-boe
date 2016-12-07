# ApplicationController class
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :show_request_details
  before_action :set_log_level

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
