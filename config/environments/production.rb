Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.log_level = :debug
  config.log_tags = [:request_id]
  # config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
  # config.action_mailer.default_url_options = { host: ENV['contenidoboe_url'] }
  # config.action_mailer.asset_host = ENV['contenidoboe_url']
  # config.action_mailer.delivery_method = :smtp
  # config.action_mailer.smtp_settings = {
  #   address: ENV['smtp_address'],
  #   port: 587,
  #   enable_starttls_auto: true,
  #   user_name: ENV['smtp_username'],
  #   password: ENV['smtp_password'],
  #   authentication: :plain,
  #   domain: ENV['smtp_domain']
  # }

  # config.action_mailer.logger = ActiveSupport::Logger.new('mailer.log')
  # config.action_mailer.logger.level = ActiveSupport::Logger::Severity::INFO

  # config.middleware.use ExceptionNotification::Rack, email: {
  #   email_prefix: '[ERROR in contenidoboe in PRODUCTION SERVER ]',
  #   sender_address: %(GeNotifier <notifier@contenidoboe.es>),
  #   exception_recipients: %w(embasbm@gmail.com)
  # }
end
