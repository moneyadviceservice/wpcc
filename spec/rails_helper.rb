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

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# a workaround to avoid MonitorMixin double-initialize error
# https://github.com/rails/rails/issues/34790#issuecomment-681034561
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.6.0')
  if Gem::Version.new(Rails.version) < Gem::Version.new('5.0.0')
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('2.7.0')
          @mon_data = nil
          @mon_data_owner_object_id = nil
        else
          @mon_mutex = nil
          @mon_mutex_owner_object_id = nil
        end
        initialize
      end
    end
  else
    warn "Monkeypatch for ActionController::TestResponse is no longer needed"
  end
end
