module Wpcc
  class BaseFilter
    def self.before(controller)
      new(controller).filter
    end

    def self.after(controller)
      before(controller)
    end

    attr_reader :controller
    delegate :session, :wpcc_root_path, :redirect_to, to: :controller

    def initialize(controller)
      @controller = controller
    end
  end
end
