module Wpcc
  class PeriodContributionCalculator
    include ActiveModel::Model

    attr_accessor :eligible_salary,
                  :salary_frequency,
                  :employee_percent,
                  :employer_percent,
                  :tax_relief_percent,
                  :name

    SALARY_FREQUENCY_CONVERSIONS = YAML.load_file(
      Wpcc::Engine.root.join('config', 'salary_frequency_conversions.yml')
    )
    TAX_RELIEF_LIMIT_BY_FREQUENCY =
      SALARY_FREQUENCY_CONVERSIONS['tax_relief_limit_by_frequency']

    def contribution
      log_calculation
      PeriodContribution.new(
        name: name,
        employee_contribution: employee_contribution,
        employer_contribution: employer_contribution,
        total_contributions: total_contributions,
        tax_relief: tax_relief
      )
    end

    private

    def log_calculation
      Rails.logger.info(
        <<-MESSAGE.strip_heredoc
          Calculating period #{name} with:
          Eligible Salary: #{eligible_salary}
          Employee percent: #{employee_percent}
          Employer percent: #{employer_percent}
          Tax relief percent: #{tax_relief_percent}
        MESSAGE
      )
    end

    def employee_contribution
      contribution_for_percent(employee_percent)
    end

    def employer_contribution
      contribution_for_percent(employer_percent)
    end

    def tax_relief
      result = (employee_contribution * (tax_relief_percent / 100.00)).round(2)

      [TAX_RELIEF_LIMIT_BY_FREQUENCY[salary_frequency], result].min
    end

    def total_contributions
      (employee_contribution + employer_contribution).round(2)
    end

    def contribution_for_percent(percent)
      ((eligible_salary.to_f / salary_frequency) * (percent / 100.00)).round(2)
    end
  end
end
