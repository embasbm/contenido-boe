# rubocop:disable LineLength
# server 'staging.api.airtimerewards.co.uk', roles: [:web, :app, :db], primary: true

set :repo_url,        'git@bitbucket.org:embamoussa/contenido-boe.git'
set :application,     'contenido-boe'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0

set :pty, false
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

set :linked_dirs, %w(log tmp/pids public/system)

def red(str)
  "\e[31m#{str}\e[0m"
end

def current_git_branch
  branch = `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(%r{^refs\/heads\/}, '')
  puts "Deploying branch #{red branch}"
  branch
end

set :branch, current_git_branch

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end

namespace :deploy do
  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

namespace :figaro do
  desc 'SCP transfer figaro configuration to the shared folder'
  task :setup do
    on roles(:app) do
      upload! 'config/application.yml', "#{shared_path}/application.yml", via: :scp
    end
  end

  desc 'Symlink application.yml to the release path'
  task :symlink do
    on roles(:app) do
      execute "ln -sf #{shared_path}/application.yml\
       #{release_path}/config/application.yml"
    end
  end
end
after 'deploy:started', 'figaro:setup'
after 'deploy:updating', 'figaro:symlink'

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
