source 'https://rubygems.org'
source 'http://gems.dev.mas.local'

# Declare your gem's dependencies in wpcc.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

ruby '2.5.3'

gem 'bowndler'
gem 'rails', '~> 4.2.7'
gem 'rubocop', '~> 0.63.1', require: false
gem 'sass-rails'
gem 'turbolinks'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'launchy'
  gem 'pry-rails'
  gem 'rb-readline'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers', '~> 3.1'
end

group :test do
  gem 'brakeman', '~> 4.5.1', require: false
  gem 'capybara', '< 3.0'
  gem 'cucumber-rails', require: false
  gem 'danger', require: false
  gem 'danger-rubocop', require: false
  gem 'poltergeist'
  gem 'simplecov', require: false
  gem 'site_prism'
  gem 'timecop'
  gem 'tzinfo-data'
end
