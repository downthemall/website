RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
end

RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_requires, 'requires:'
end

