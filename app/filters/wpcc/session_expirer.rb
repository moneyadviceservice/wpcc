module Wpcc
  class SessionExpirer < ::Wpcc::BaseFilter
    WPCC_SESSION_EXPIRY_LIMIT = 30.minutes

    SESSION_KEYS = [
      YourContributionsSessionVerifier::SESSION_KEYS,
      YourResultsSessionVerifier::SESSION_KEYS
    ].flatten.map(&:to_s).freeze

    def filter
      expire_wpcc_session if wpcc_session_expired?

      update_wpcc_session_expiry
    end

    private

    def wpcc_session_expired?
      session[:wpcc_expires_at] && (session[:wpcc_expires_at] <= Time.current)
    end

    def expire_wpcc_session
      SESSION_KEYS.each do |key|
        session[key] = nil
      end
    end

    def update_wpcc_session_expiry
      session[:wpcc_expires_at] = Time.current + WPCC_SESSION_EXPIRY_LIMIT
    end
  end
end
