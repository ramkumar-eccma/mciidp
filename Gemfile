source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
gem 'bootstrap-sass', '~> 3.3.5'
gem 'font-awesome-rails', '4.3.0.0'

# Use sqlite3 as the database for Active Record
gem 'mysql2', '~>0.3.18'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

#Used for login purpose
gem 'devise', '3.4.1'
gem 'devise-i18n-views'

# Use wice_grid used for search this is added by me
gem "wice_grid", '3.6.0.pre4'

#Using this gem enhances activerecord to change the default behavior for the creation of attribute accessors.Refer =>http://www.rubydoc.info/gems/safe_attributes/1.0.1/
gem 'safe_attributes'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

# This is for Deployment
group :development do
	gem 'capistrano'
	gem 'capistrano-bundler'
	gem 'capistrano-rails'
	gem 'capistrano3-unicorn'
end

# This is for production to load all the files
group :production do
  gem 'therubyracer'
end


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
