require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment', __dir__)
abort('Do not run the tests in production mode!!!') if Rails.env.production?
require 'rspec/rails'
require 'simplecov'

Dir[
  ::Wpcc::Engine.root.join('spec/shared_examples/**.rb')
].each { |f| require f }

SimpleCov.start do
  add_filter '/spec/'
end

SimpleCov.minimum_coverage 85

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
