module Wpcc
  class SessionLogger < ::Wpcc::BaseFilter
    attr_reader :logger

    def initialize(controller)
      @logger = Rails.logger
      super(controller)
    end

    def filter
      logger.info("Session: #{session_information}")
    end

    private

    def session_information
      session.to_hash.slice(
        'salary',
        'salary_frequency',
        'contribution_preference',
        'employee_percent',
        'employer_percent',
        'eligible_salary',
        'wpcc_expires_at'
      )
    end
  end
end
