module Wpcc
  class SessionResetter < SessionExpirer
    def filter
      expire_wpcc_session
      controller.redirect_to controller.new_your_detail_path
    end
  end
end
