module Wpcc
  class EngineController < Wpcc.parent_controller.constantize
    protect_from_forgery

    layout 'wpcc/engine'
    before_action :log_session
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
  end
end
