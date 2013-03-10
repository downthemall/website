require 'unit_spec_helper'
require 'active_record'
require 'ostruct'

# ActiveRecord gems
require 'straight_auth'
require 'paperclip'

# Stubbing padrino
Padrino = OpenStruct.new(logger: nil, env: :test) unless defined?(Padrino)

autoload_paths = ActiveSupport::Dependencies.autoload_paths
%w(models).each do |path|
  autoload_paths.push(path) unless autoload_paths.include?(path)
end

require 'config/database'
require 'fabrication'

rails_root = File.expand_path('../../', __FILE__)
Dir[File.join(rails_root, "spec/support/models/**/*.rb")].each {|f| require f}
