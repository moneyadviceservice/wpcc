module Wpcc
  class FullContributionCalculator < ContributionCalculator
    def eligible_salary
      salary
    end

    def employee_percent
      1
    end

    def employer_percent
      return 0 if salary < lower_earnings_threshold
      return 1 if salary >= lower_earnings_threshold
    end
  end
end
