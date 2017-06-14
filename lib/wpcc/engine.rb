module Wpcc
  class Engine < ::Rails::Engine
    isolate_namespace Wpcc

    initializer 'wpcc precompile hooks', :group => :all do |app|
      app.config.assets.precompile += [

      ]
    end
  end
end
