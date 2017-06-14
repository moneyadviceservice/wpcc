module Wpcc
  class EngineController < ActionController::Base
    protect_from_forgery with: :exception

    layout 'wpcc/engine'
  end
end
