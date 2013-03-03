require 'active_support/dependencies'
root = File.expand_path('../../', __FILE__)
$LOAD_PATH.unshift(root) unless $LOAD_PATH.include?(root)
autoload_paths = ActiveSupport::Dependencies.autoload_paths
%w(app/services app/presenters lib).each do |path|
  autoload_paths.push(path) unless autoload_paths.include?(path)
end

PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'

Dir[Padrino.root("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_requires, 'requires:'
end

def app
  Padrino.application
end

Capybara.app = app
Capybara.save_and_open_page_path = 'tmp'

