module Wpcc
  class EngineController < Wpcc.parent_controller.constantize
    protect_from_forgery

    layout 'wpcc/engine'
    before_action :log_session, :check_session
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

    def check_session
      session_expired? ? reset_session : update_session_expiry
    end

    def session_expired?
      session[:expires_at] && session[:expires_at] <= Time.current
    end

    def update_session_expiry
      session[:expires_at] = Time.current + 30.minutes
    end
  end
end
