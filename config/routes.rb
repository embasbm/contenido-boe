Rails.application.routes.draw do
  require "sidekiq/web"
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(username, ENV["sidekiq_username"]) &
      ActiveSupport::SecurityUtils.secure_compare(password, ENV["sidekiq_password"])
  end if Rails.env.production?
  mount Sidekiq::Web, at: "/sidekiq"

  resources :diaries, only: [:index]
  root to: 'diaries#index'
  get '*path' => redirect('/')
end
