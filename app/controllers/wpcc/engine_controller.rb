module Wpcc
  class EngineController < Wpcc.parent_controller.constantize
    protect_from_forgery

    layout 'wpcc/engine'
  end
end
