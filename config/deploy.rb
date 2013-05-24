set :application, "esusu"
set :scm, :git
#default_run_options[:pty] = true  # Must be set for the password prompt
set :repository,  "git@github.com:daser/kungiya.git"
set :branch, "master"
set :migrate_target,  :current
set :rails_env, "production"
set :deploy_to, "/var/www/esusu"
set :normalize_asset_timestamps, false

set :ssh_options, { :forward_agent => true }

set :stages, ["staging", "production"]
set :default_stage, "staging"

set :user, "nignux"
set :group, "root"
set :use_sudo, false

set :deploy_via, :remote_cache


# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "50.116.41.143"                          # Your HTTP server, Apache/etc
role :app, "50.116.41.143"                          # This may be the same as your `Web` server
role :db,  "50.116.41.143", :primary => true # This is where Rails migrations will run
role :db,  "50.116.41.143"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end