ENV['RAILS_ENV'] ||= 'test'
ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '../../../spec/dummy'

require 'cucumber/rails'
require 'capybara/poltergeist'
require 'rspec/rails'

ActionController::Base.allow_rescue = false
Capybara.javascript_driver = :poltergeist
