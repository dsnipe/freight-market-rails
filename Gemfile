source 'https://rubygems.org'


gem 'rails', '4.2'
gem 'rails-api'

gem 'mongoid'

# Pub/Sub service
gem 'wisper'

# Backgound jobs and async
gem 'delayed_job'
gem 'delayed_job_mongoid'
gem 'clockwork'

# API
gem 'grape'
gem 'oj' # fastest JSON parser

# Messaging
gem 'pusher'

# Utils
gem 'airbrake'
gem 'enumerize'

group 'development' do
	gem 'letter_opener'
	gem 'binding_of_caller', platforms: :ruby
	gem 'jazz_hands', github: 'nixme/jazz_hands', branch: 'bring-your-own-debugger', platforms: :ruby
	gem 'pry-byebug', platforms: :ruby   # This may or may not work with 2.1.2 either, so remove if you still get errorrs
	gem 'quiet_assets'
end

group :development, :test do
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'pry'
  gem 'guard-rspec'
  gem 'rspec-rails', '~> 3.1'
  gem 'rspec-collection_matchers'
  gem 'airborne' # rspec api testing
  gem 'factory_girl_rails'
	gem 'ffaker'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Deploy with Capistrano
# gem 'capistrano', :group => :development
