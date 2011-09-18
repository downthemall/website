$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"

set :rvm_ruby_string, 'ruby-1.9.2-p290@publishow'
set :rvm_bin_path, "/usr/local/rvm/bin"

set :application, "DownThemAll! Website"
set :repository,  "git://github.com/downthemall/website.git"

set :scm, :git

server "ps.s.welaika.com", :app, :web, :db, :primary => true

set :user, "website"
set :deploy_to, "/home/website/apps/website"
set :use_sudo, false
set :rails_env, 'production'
set :deploy_via, :remote_cache
set :branch, "master"

require "bundler/capistrano"
require 'hoptoad_notifier/capistrano'

after "deploy", "deploy:cleanup"
