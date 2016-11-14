source 'https://rubygems.org'

gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'twitter-bootstrap-rails'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap', '~> 4.0.0.alpha3.1'
gem 'high_voltage'
gem 'mongoid', git: 'https://github.com/mongodb/mongoid.git'

gem "figaro"

gem 'sidekiq'
gem 'sidetiq'
gem 'sidekiq-status'

gem 'exception_notification'

group :development, :test do
  gem 'byebug', platform: :mri
end
group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
group :development do
  gem 'better_errors'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub', require: nil
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring-commands-rspec'
  gem 'rubocop'
end
group :development do
    gem "capistrano", '3.4.0'
    gem 'capistrano-rbenv',    '2.0.4',   require: false
    gem 'capistrano-rails',    '1.1.6',   require: false
    gem 'capistrano-bundler',  '~> 1.1',  require: false
    gem 'capistrano3-puma',    '1.2.1',   require: false
    gem 'capistrano-sidekiq',  '0.5.4',   require: false
    gem 'capistrano-figaro',   '1.0.0.0', require: false
    gem 'capistrano-rake',     '0.1.0',   require: false
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'mongoid-rspec'
end
