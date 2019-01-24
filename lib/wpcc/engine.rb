require 'modernizr-rails'

module Wpcc
  mattr_accessor :parent_controller

  class Engine < ::Rails::Engine
    isolate_namespace Wpcc
    Wpcc.parent_controller = '::ApplicationController'

    initializer 'wpcc precompile hooks', group: :all do |app|
      app.config.assets.precompile += %w[
        wpcc/require_config.js
        wpcc/components/*.js
        wpcc/print.css
      ]
    end

    config.autoload_paths += %W[
      #{config.root}/app/presenters
      #{config.root}/app/validators
      #{config.root}/app/filters
    ]
  end
end
