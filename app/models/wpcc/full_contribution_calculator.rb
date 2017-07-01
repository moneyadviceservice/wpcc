require 'active_model'

module Wpcc
  class FullContributionCalculator < ContributionCalculator

    def calculate
      Wpcc::YourContribution.new(
        eligible_salary: salary,
        employee_percent: 1,
        employer_percent: employer_percent
      )  
    end

    def employer_percent
      return 0 if salary < LOWER_EARNINGS_THRESHOLD
      return 1 if salary >= LOWER_EARNINGS_THRESHOLD
    end

  end
end
