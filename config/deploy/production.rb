server 'contenido-boe.es', roles: [:web, :app, :db], primary: true

set :stage,       :production
set :rails_env,   :production

role :app, %w(deploy@contenido-boe.es)
role :web, %w(deploy@contenido-boe.es)
role :db,  %w(deploy@contenido-boe.es)
