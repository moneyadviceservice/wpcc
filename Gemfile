source 'https://rubygems.org'
source 'http://gems.dev.mas.local'

# Declare your gem's dependencies in wpcc.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

ruby '2.4.1'

gem 'bowndler'
gem 'dough-ruby',
    github: 'moneyadviceservice/dough',
    branch: 'upgrade-to-rails-5'
gem 'jquery-rails'
gem 'rubocop', require: false
gem 'sass-rails'
gem 'turbolinks'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug'
  gem 'launchy'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

group :test do
  gem 'brakeman', '~> 4.1.1', require: false
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'poltergeist'
  gem 'rails-controller-testing'
  gem 'simplecov', require: false
  gem 'site_prism'
  gem 'timecop'
  gem 'tzinfo-data'
end
