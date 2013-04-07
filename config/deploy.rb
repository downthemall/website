require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :domain, 'ns313038.ovh.net'
set :deploy_to, '/home/website/apps/website'
set :repository, 'git://github.com/downthemall/website.git'
set :branch, 'padrino'
set :shared_paths, ['config/db_credentials.rb', 'log', 'public/system']
set :user, 'website'
set :rvm_path, '/usr/local/rvm/scripts/rvm'
set :bundle_prefix, lambda { %{PADRINO_ENV="#{rails_env}" #{bundle_bin} exec} }

task :environment do
  invoke :'rvm:use[ruby-1.9.3-p385@default]'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/public/system"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/public/system"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/db_credentials.rb"]
  queue  %[echo "-----> Be sure to edit 'shared/config/db_credentials.rb'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    # invoke :'rails:assets_precompile'

    to :launch do
      queue 'touch tmp/restart.txt'
    end
  end
end

