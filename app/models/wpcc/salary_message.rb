module Wpcc
  class SalaryMessage
    include ActiveModel::Model
    extend WpccConfig
    attr_accessor :salary, :salary_frequency, :employee_percent, :text

    FREQUENCY_THRESHOLDS = frequency_conversions

    OPT_IN_THRESHOLDS = opt_in_thresholds_by_frequency.freeze

    TAX_RELIEF_THRESHOLDS = FREQUENCY_THRESHOLDS[
      'tax_relief_on_salary_by_frequency'
    ].freeze

    TAX_RELIEF_MAX_CONTRIBUTION = 40_000

    WARNING_RANGE = 10

    def manually_opt_in?
      salary >= opt_in_lower_limit && salary <= opt_in_upper_limit
    end

    def salary_below_tax_relief_threshold?
      valid_salary_frequency? && salary_below_frequency_threshold?
    end

    def salary_below_pension_limit?
      salary < opt_in_lower_limit
    end

    def salary_near_pension_limit?
      near_limit?(opt_in_lower_limit)
    end

    def salary_near_manual_opt_in_limit?
      near_limit?(opt_in_upper_limit)
    end

    def above_max_contribution?
      employee_contribution > TAX_RELIEF_MAX_CONTRIBUTION
    end

    private

    def near_limit?(limit)
      salary.between?(
        limit - WARNING_RANGE,
        limit + WARNING_RANGE
      )
    end

    def valid_salary_frequency?
      TAX_RELIEF_THRESHOLDS.key?(salary_frequency)
    end

    def salary_below_frequency_threshold?
      salary < TAX_RELIEF_THRESHOLDS[salary_frequency]
    end

    def employee_contribution
      frequency = Wpcc::SalaryFrequencyConverter.convert(salary_frequency)
      frequency * salary * employee_percent.to_i / 100
    end

    def opt_in_lower_limit
      OPT_IN_THRESHOLDS['lower'][salary_frequency]
    end

    def opt_in_upper_limit
      OPT_IN_THRESHOLDS['upper'][salary_frequency]
    end
  end
end
