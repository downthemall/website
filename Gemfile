source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'jquery-rails'
gem 'slim'
gem 'sqlite3', :group => [:development, :test]
gem 'css3buttons'
gem 'twitter'
gem 'feed-normalizer'
gem 'html_truncator'

group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'compass', git: 'https://github.com/chriseppstein/compass.git',  branch: 'rails31'
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

group :test do
  gem 'turn', require: false
end

group :production do
  # needed by heroku cedar stack
  gem 'pg'
end

