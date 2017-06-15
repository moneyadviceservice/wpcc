module Wpcc
  class EngineController < Wpcc.parent_controller.constantize
    protect_from_forgery with: :exception

    layout 'wpcc/engine'
  end
end
