source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # for Console
  gem 'pry-rails'     # A powerful alternative to the standard IRB shell for Ruby
  gem 'pry-coolline'  # Live syntax-highlighting for the Pry REPL
  gem 'hirb-unicode'  # Unicode support for hirb
  gem 'awesome_print' # Pretty print your Ruby objects with style
  gem 'pry-byebug'    # Pry navigation commands via byebug
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'annotate'

  # check N+1 query
  gem 'bullet'
end

gem "config"
gem 'dotenv-rails'
gem "slim-rails"
gem 'devise'

# soft delete
gem 'paranoia', '~> 2.0'

# pagination
gem 'kaminari'
# Rails I18n de-facto standard library for ActiveRecord model/data translation.
gem 'globalize', '~> 5.0.0'

# File upload
gem "paperclip", "~> 4.3"
# Ckeditor
gem 'ckeditor'

# Authorization
gem 'cancancan', '~> 1.13', '>= 1.13.1'

# Friendly
gem 'friendly_id', '~> 5.1.0'
# A wrapper for MailChimp API 3.0
gem 'gibbon', '~> 2.1'

# ransack
gem 'ransack'

# Login with social
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'

#gem excel file
gem 'roo'
gem 'roo-xls'
# Sidekiq
gem 'sidekiq'

# Send email asycjob devise
gem 'devise-async'

group :deployment do
  gem 'capistrano', '~> 3.3.5'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-unicorn-nginx', '~> 3.2.0'
  gem 'unicorn'
  gem 'capistrano-rvm'
  gem "bower-rails", "~> 0.9.2"
  gem 'whenever', require: false
  gem 'capistrano-sidekiq', github: 'seuros/capistrano-sidekiq'
  gem 'capistrano-faster-assets', '~> 1.0'
end