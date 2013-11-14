source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'
gem 'exifr', :git => 'git://github.com/picuous/exifr.git'
gem 'unf'

group :development,:test do
  gem 'sqlite3'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'factory_girl_rails', "~> 4.0", :require => false
  gem 'debugger'
end
group :production do
  gem 'pg'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
end
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'devise'

gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"

gem 'rmagick'
gem 'carrierwave'
gem 'fog'
gem 'carrierwave_direct'
gem 'sidekiq'
gem 'figaro'
gem 'rack-offline'
