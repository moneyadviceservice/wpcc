module Wpcc
  class YourResultsSessionVerifier < ::Wpcc::SessionVerifier
    SESSION_KEYS =
      %i[
        eligible_salary
        employee_percent
        employer_percent
      ].freeze

    def session_keys
      SESSION_KEYS
    end
  end
end
