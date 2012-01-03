$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"

set :rvm_ruby_string, 'ruby-1.9.2-p290@website'
set :rvm_bin_path, "/usr/local/rvm/bin"

set :application, "DownThemAll! Website"
set :repository,  "git://github.com/downthemall/website.git"

set :scm, :git

server "ns313038.ovh.net", :app, :web, :db, :primary => true

set :user, "website"
set :deploy_to, "/home/website/apps/website"
set :use_sudo, false
set :rails_env, 'production'
set :deploy_via, :remote_cache
set :branch, "master"

require "bundler/capistrano"
require 'hoptoad_notifier/capistrano'

after "deploy", "deploy:cleanup"

namespace :db do
  task :symlink, :except => { :no_release => true } do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/paypal.yml #{release_path}/config/paypal.yml"
  end
end

deploy.task :restart, :roles => :app do
  run "touch #{current_path}/tmp/restart.txt"
end

after "deploy:finalize_update", "db:symlink"
before "deploy:assets:precompile", "bundle:install"
