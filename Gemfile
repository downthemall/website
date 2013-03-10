source 'https://rubygems.org'

gem 'pg'
gem 'rake'
gem 'i18n', '~> 0.6.4'
gem 'padrino-helpers', github: 'padrino/padrino-framework' # waiting for 0.10.8
gem 'padrino', '~> 0.10.7'
gem 'rack-flash3'
gem 'sass', '~> 3.2.7'
gem 'slim', '~> 1.3.6'
gem 'bcrypt-ruby'
gem 'coffee-script', '~> 2.2.0'
# # https://github.com/nightsailer/padrino-sprockets/pull/2
gem 'sprockets', '~> 2.9.0'
gem 'padrino-sprockets', require: "padrino/sprockets"
gem 'jsmin', '~> 1.0.1'
gem 'activerecord', '~> 3.2.12', require: "active_record"
gem 'activemerchant', "~> 1.31.1"
gem 'redcarpet', '~> 2.2.2'
gem 'will_paginate', '~> 3.0', require: false
gem 'pundit', github: 'stefanoverna/pundit', branch:'master'
gem 'straight_auth', github: 'stefanoverna/straight_auth', branch: 'master'
gem "paperclip", "~> 3.0"

group :development do
  gem 'letter_opener'
  gem 'launchy'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock', '1.10', require: false
  gem 'fabrication'
end
