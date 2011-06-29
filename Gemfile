source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'
gem 'mongo_mapper'
gem 'mongo'
gem 'bson_ext'
gem 'bson'
gem 'thin'
gem 'bcrypt-ruby', :require => 'bcrypt'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'
group :production do
    gem 'therubyracer-heroku'
end

group :development, :test do
    gem "rspec-rails"
end

group :test do
    gem "factory_girl"
    gem "factory_girl_rails"
    gem "webrat"
end


# Asset template engines
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
