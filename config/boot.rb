# Defines our constants
PADRINO_ENV  = ENV['PADRINO_ENV'] ||= ENV['RACK_ENV'] ||= 'development'  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

Padrino.set_load_paths Padrino.root("app/services")
Padrino.set_load_paths Padrino.root("app/helpers")
Padrino.set_load_paths Padrino.root("app/presenters")

Slim::Engine.set_default_options disable_escape: true

# Padrino.after_load do
#   I18n.reload! if Padrino.env == :development
# end

Padrino.load!
