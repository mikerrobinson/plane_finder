source 'https://rubygems.org'

gem 'rails', '3.2.6'
gem 'thin'
gem 'bootstrap-sass', '2.0.0'
gem 'bcrypt-ruby'

gem 'devise'
gem "mongoid", "~> 2.4"
gem "bson_ext", "~> 1.5"
gem 'mongoid_fulltext'
gem "geocoder"

gem 'simple_form'
gem 'will_paginate'
gem 'will_paginate-bootstrap'

group :development, :test do
  gem 'pry'
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.10.0'
  gem 'guard-rspec'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.4'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

gem 'jquery-rails', '2.0.0'

# Test gems on Macintosh OS X
group :test do
  gem 'cucumber-rails', '1.2.1', require: false
  gem 'capybara', '1.1.2'
  gem 'rb-fsevent', :require => false
  gem 'growl'
  gem 'guard-spork'
  gem 'spork'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  # gem 'mongoid-rspec'  
end

group :production do
  gem 'pg', '0.12.2'
end