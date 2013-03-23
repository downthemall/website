require 'bundler'
Bundler.setup # we have gems in repos
require 'vcr'
require 'timecop'
require 'pundit'
require 'active_support/dependencies'

root = File.expand_path('../../', __FILE__)
$LOAD_PATH.unshift(root) unless $LOAD_PATH.include?(root)
Dir[File.join("spec/support/unit/**/*.rb")].each {|f| require f}

autoload_paths = ActiveSupport::Dependencies.autoload_paths
%w(app/policies app/services lib).each do |path|
  autoload_paths.push(path) unless autoload_paths.include?(path)
end
