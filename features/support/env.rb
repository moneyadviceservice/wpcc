ENV['RAILS_ENV'] ||= 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '../../../spec/dummy'

require 'cucumber/rails'
require 'selenium/webdriver'
require 'rspec/rails'

ActionController::Base.allow_rescue = false

Capybara.register_driver :chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w(headless no-sandbox disable-gpu window-size=2500,2500)
  )

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome_headless
Capybara.default_max_wait_time = 20

Cucumber::Rails::Database.autorun_database_cleaner = false
