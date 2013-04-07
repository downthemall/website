require 'padrino-core/cli/rake'
require 'rspec/core/rake_task'

PadrinoTasks.use(:activerecord)
PadrinoTasks.use(:database)
PadrinoTasks.use(:seed)
PadrinoTasks.init

RSpec::Core::RakeTask.new(:spec)
task default: :spec

