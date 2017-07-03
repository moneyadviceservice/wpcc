module Wpcc
  mattr_accessor :parent_controller

  class Engine < ::Rails::Engine
    isolate_namespace Wpcc
    Wpcc.parent_controller = '::ApplicationController'

    initializer 'wpcc precompile hooks', group: :all do |app|
      app.config.assets.precompile += [

      ]
    end

    config.autoload_paths += %W[#{config.root}/app/presenters]
  end
end
