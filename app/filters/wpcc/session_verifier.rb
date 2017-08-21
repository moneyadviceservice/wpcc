module Wpcc
  class SessionVerifier < ::Wpcc::BaseFilter
    def filter
      redirect_to wpcc_root_path if session_keys.any? do |key|
        session[key].blank?
      end
    end

    def session_keys
      raise NotImplementedError
    end
  end
end
