require 'active_support/dependencies'
root = File.expand_path('../../', __FILE__)
$LOAD_PATH.unshift(root) unless $LOAD_PATH.include?(root)
Dir[File.join("spec/support/unit/**/*.rb")].each {|f| require f}

require 'vcr'
require 'timecop'
require 'webmock'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
end

autoload_paths = ActiveSupport::Dependencies.autoload_paths
%w(app/services lib).each do |path|
  autoload_paths.push(path) unless autoload_paths.include?(path)
end
