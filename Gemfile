source 'https://rubygems.org'
source 'http://gems.dev.mas.local'

# Declare your gem's dependencies in wpcc.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

ruby '2.3.3'

gem 'bowndler'
gem 'jquery-rails'
gem 'rails', '~> 4.2.7'
gem 'rubocop', '~> 0.49.1', require: false
gem 'sass-rails'
gem 'turbolinks'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'launchy'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers', '~> 3.1'
end

group :test do
  gem 'brakeman', require: false
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'poltergeist'
  gem 'simplecov', require: false
  gem 'site_prism'
  gem 'timecop'
  gem 'tzinfo-data'
end
