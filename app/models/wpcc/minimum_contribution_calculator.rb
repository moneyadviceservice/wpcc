require 'active_model'

module Wpcc
  class MinimumContributionCalculator < ContributionCalculator

    def calculate
      Wpcc::YourContribution.new(
        eligible_salary: eligible_salary,
        employee_percent: 1,
        employer_percent: 1
      )
    end

    def eligible_salary
      return upper_less_lower_limit if salary > UPPER_EARNINGS_THRESHOLD
      return salary_less_lower_limit if salary <= UPPER_EARNINGS_THRESHOLD
    end

    def upper_less_lower_limit
      UPPER_EARNINGS_THRESHOLD - LOWER_EARNINGS_THRESHOLD
    end

    def salary_less_lower_limit
      salary - LOWER_EARNINGS_THRESHOLD
    end

  end
end
