# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

require "capistrano-db-tasks"

set :repo_url, "git@github.com:maranamjd/rails-aws.git"

# Default deploy_to directory is /var/www/my_app_name

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []

# Default value for linked_dirs is []

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3
set :keep_assets, 3

set :db_remote_clean, true
set :db_local_clean, true

set :bundle_binstubs, nil # do not use shared bundle path between releases
set :bundle_path,     nil # trust bundle config to set the path
set :bundle_flags,    nil # be verbose, don't use deployment mode
set :rvm_map_bins, %w{ gem rake ruby rails bundle }

set :precompile_env, 'production'
set :assets_dir, "public/assets"
set :packs_dir, "public/packs"
set :rsync_cmd, "rsync -av --delete"
set :storage_dir, "storage/"

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure



namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart
  after :finishing, :cleanup

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end

namespace :db do
  task :seed do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end
end

namespace :service do
  task :restart do
    on roles(:app), in: :sequence, wait: 3 do
      execute :sudo, "service #{fetch :service} stop"
      execute :sudo, "service #{fetch :service} start"
    end
  end

  task :start do
    on roles(:app), in: :sequence, wait: 3 do
      execute :sudo, "service #{fetch :service} start"
    end
  end

  task :stop do
    on roles(:app), in: :sequence, wait: 3 do
      execute :sudo, "service #{fetch :service} stop"
    end
  end
end

namespace :worker do
  task :restart do
    on roles(:app), in: :sequence, wait: 3 do
      execute :sudo, "service #{fetch :worker_service} stop"
      execute :sudo, "service #{fetch :worker_service} start"
    end
  end

  task :start do
    on roles(:app), in: :sequence, wait: 3 do
      execute :sudo, "service #{fetch :worker_service} start"
    end
  end

  task :stop do
    on roles(:app), in: :sequence, wait: 3 do
      execute :sudo, "service #{fetch :worker_service} stop"
    end
  end
end