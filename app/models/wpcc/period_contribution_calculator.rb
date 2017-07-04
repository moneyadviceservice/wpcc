module Wpcc
  class PeriodContributionCalculator
    include ActiveModel::Model

    attr_accessor :eligible_salary,
                  :salary_frequency,
                  :employee_percent,
                  :employer_percent,
                  :tax_relief_percent,
                  :name

    def contribution
      PeriodContribution.new(
        name: name,
        employee_contribution: employee_contribution,
        employer_contribution: employer_contribution,
        total_contributions: total_contributions,
        tax_relief: tax_relief
      )
    end

    private

    def employee_contribution
      contribution_for_percent(employee_percent)
    end

    def employer_contribution
      contribution_for_percent(employer_percent)
    end

    def tax_relief
      (employee_contribution * (tax_relief_percent / 100.00)).round(2)
    end

    def total_contributions
      (employee_contribution + employer_contribution).round(2)
    end

    def contribution_for_percent(percent)
      ((eligible_salary / salary_frequency.to_f) * (percent / 100.00)).round(2)
    end
  end
end
