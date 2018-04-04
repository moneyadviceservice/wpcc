module Wpcc
  class FullContributionCalculator < ContributionCalculator
    def eligible_salary
      salary_per_year
    end

    def employee_percent
      percentage(:employee)
    end

    def employer_percent
      percentage(:employer)
    end

    private

    def below_threshold?
      salary_per_year < lower_salary_threshold
    end
  end
end
