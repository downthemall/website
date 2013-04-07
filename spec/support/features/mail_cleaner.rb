RSpec.configure do |config|
  config.before(:each) do
    Mail::TestMailer.deliveries.clear
  end
end

