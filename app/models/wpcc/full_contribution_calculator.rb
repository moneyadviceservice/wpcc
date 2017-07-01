require 'active_model'

module Wpcc
  class FullContributionCalculator < ContributionCalculator
    def eligible_salary
      salary
    end

    def employee_percent
      1
    end

    def employer_percent
      return 0 if salary < LOWER_EARNINGS_THRESHOLD
      return 1 if salary >= LOWER_EARNINGS_THRESHOLD
    end
  end
end
