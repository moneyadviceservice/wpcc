require 'active_model'

module Wpcc
  class MinimumContributionCalculator < ContributionCalculator
    def eligible_salary
      return upper_less_lower_limit if salary > upper_earnings_threshold
      return salary_less_lower_limit if salary <= upper_earnings_threshold
    end

    def employee_percent
      1
    end

    def employer_percent
      1
    end

    private

    def upper_less_lower_limit
      upper_earnings_threshold - lower_earnings_threshold
    end

    def salary_less_lower_limit
      salary - lower_earnings_threshold
    end
  end
end
