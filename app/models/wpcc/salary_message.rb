module Wpcc
  class SalaryMessage
    include ActiveModel::Model
    attr_accessor :salary, :salary_frequency, :employee_percent, :text

    OPT_IN_SALARY_LOWER_LIMIT = 5_876
    OPT_IN_SALARY_UPPER_LIMIT = 10_000
    TAX_RELIEF_MAX_CONTRIBUTION = 40_000
    TAX_RELIEF_THRESHOLD_RATE = {
      year: 11_500,
      month: 958.33,
      fourweeks: 884.61,
      week: 221.15
    }.freeze

    def manually_opt_in?
      !salary_below_pension_limit? && salary <= OPT_IN_SALARY_UPPER_LIMIT
    end

    def salary_below_tax_relief_threshold?
      valid_salary_frequency? && salary_below_frequency_threshold?
    end

    def salary_below_pension_limit?
      salary < OPT_IN_SALARY_LOWER_LIMIT
    end

    def above_max_contribution?
      employee_contribution > TAX_RELIEF_MAX_CONTRIBUTION
    end

    private

    def valid_salary_frequency?
      TAX_RELIEF_THRESHOLD_RATE.keys.include?(salary_frequency.to_sym)
    end

    def salary_below_frequency_threshold?
      salary < TAX_RELIEF_THRESHOLD_RATE[salary_frequency.to_sym]
    end

    def employee_contribution
      frequency = Wpcc::SalaryFrequencyConverter.convert(salary_frequency)
      frequency * salary * employee_percent.to_i / 100
    end
  end
end
