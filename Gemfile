source 'https://rubygems.org'

# force Bundler to use SSL
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in wpcc.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

ruby IO.read('.ruby-version').chomp

gem 'bigdecimal', '1.3.5'
gem 'bowndler'
gem 'dough-ruby', github: 'moneyadviceservice/dough', branch: 'PostMessages_v5.45'
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
  gem 'sprockets', '~> 3.7.2'
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
