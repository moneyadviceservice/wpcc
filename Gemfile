source 'https://rubygems.org'
source 'http://gems.dev.mas.local'

# Declare your gem's dependencies in wpcc.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

ruby '2.2.5'

gem 'bowndler', git: 'https://github.com/moneyadviceservice/bowndler'
gem 'jquery-rails'
gem 'rails', '~> 4.2.7'
gem 'sass-rails'
gem 'turbolinks'

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers', '~> 3.1'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem 'site_prism'
end
