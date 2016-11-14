server 'contenido-boe.es', roles: [:web, :app, :db], primary: true

set :stage,       :production
set :rails_env,   :production

role :app, %w(deploy@contenido-boe.es)
role :web, %w(deploy@contenido-boe.es)
role :db,  %w(deploy@contenido-boe.es)

set :sidekiq_env,           'production'
set :sidekiq_processes,     2
set :sidekiq_config, -> { File.join(current_path, 'config', 'sidekiq.yml') }
set :sidekiq_pid, -> { File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid') }
set :sidekiq_log, -> { File.join(shared_path, 'log', 'sidekiq.log') }
set :sidekiq_default_hooks, true
set :sidekiq_role,          :web
