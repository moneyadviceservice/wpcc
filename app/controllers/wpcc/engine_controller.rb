module Wpcc
  class EngineController < Wpcc.parent_controller.constantize
    WPCC_SESSION_EXPIRY_LIMIT = 30.minutes

    protect_from_forgery

    layout 'wpcc/engine'

    before_action :log_session
    before_action :expire_wpcc_session, if: :wpcc_session_expired?
    before_action :update_wpcc_session_expiry, unless: :wpcc_session_expired?

    after_action :log_session

    private

    def log_session
      Rails.logger.info("Session: #{session_information}")
    end

    def session_information
      session.to_hash.slice(
        'salary',
        'salary_frequency',
        'contribution_preference',
        'employee_percent',
        'employer_percent',
        'eligible_salary'
      )
    end

    def wpcc_session_expired?
      session[:wpcc_expires_at] && session[:wpcc_expires_at] <= Time.current
    end

    def update_wpcc_session_expiry
      session[:wpcc_expires_at] = Time.current + WPCC_SESSION_EXPIRY_LIMIT
    end

    def expire_wpcc_session
      wpcc_session_keys.each do |key|
        session[key] = nil
      end
    end

    def wpcc_session_keys
      %i[
        age
        gender
        salary
        salary_frequency
        contribution_preference
        eligible_salary
        employee_percent
        employer_percent
      ]
    end
  end
end
