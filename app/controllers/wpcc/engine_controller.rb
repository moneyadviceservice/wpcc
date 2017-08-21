module Wpcc
  class EngineController < Wpcc.parent_controller.constantize
    protect_from_forgery

    layout 'wpcc/engine'

    before_action SessionLogger
    after_action SessionLogger
    before_action SessionExpirer
  end
end
