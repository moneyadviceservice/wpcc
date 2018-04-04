module Wpcc
  class MinimumContributionCalculator < ContributionCalculator
    def eligible_salary
      return upper_less_lower_limit if salary_per_year > upper_salary_threshold

      return salary_per_year_less_lower_limit if
        salary_per_year <= upper_salary_threshold
    end

    def employee_percent
      percentage(:employee)
    end

    def employer_percent
      percentage(:employer)
    end

    def below_threshold?
      false
    end

    private

    def upper_less_lower_limit
      upper_salary_threshold - lower_salary_threshold
    end

    def salary_per_year_less_lower_limit
      salary_per_year - lower_salary_threshold
    end
  end
end
