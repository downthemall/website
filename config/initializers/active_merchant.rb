settings = YAML.load(ERB.new(File.read("#{Rails.root}/config/paypal.yml")).result)[Rails.env]

PAYPAL_ACCOUNT = settings['account']
ActiveMerchant::Billing::Base.mode = :test if settings['test']

ActionView::Base.send(:include, ActiveMerchant::Billing::Integrations::ActionViewHelper)
