server "52.199.237.250", user: "rails-aws", roles: %w{web app db}
set :rails_env, 'production'

set :application, "rails-aws"
set :branch, "main"
set :user, "rails-aws"

set :full_app_name, "rails-aws"
set :deploy_to, "/home/rails-aws/#{fetch :application}"

append :linked_files, "config/database.yml", 'config/master.key'
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

set :ssh_options, { forward_agent: true }

set :rbenv_path, "/home/#{fetch(:user)}/.rbenv"
set :rbenv_type, :user
set :rbenv_ruby, "3.1.2"

set :tmp_dir, "/home/#{fetch(:user)}/.capistrano-tmp"