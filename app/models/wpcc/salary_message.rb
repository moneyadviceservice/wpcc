module Wpcc
  class SalaryMessage
    include ActiveModel::Model
    attr_accessor :salary, :salary_frequency, :employee_percent, :text

    THRESHOLDS_FILE = Wpcc::Engine.root.join(
      'config', 'salary_frequency_conversions.yml'
    ).freeze

    FREQUENCY_THRESHOLDS = YAML.load_file(THRESHOLDS_FILE).freeze

    OPT_IN_THRESHOLDS = FREQUENCY_THRESHOLDS[
      'manual_opt_in_by_frequency'
    ].freeze

    TAX_RELIEF_THRESHOLDS = FREQUENCY_THRESHOLDS[
      'tax_relief_on_salary_by_frequency'
    ].freeze

    TAX_RELIEF_MAX_CONTRIBUTION = 40_000

    def manually_opt_in?
      !salary_below_pension_limit? && salary <= opt_in_upper_limit
    end

    def salary_below_tax_relief_threshold?
      valid_salary_frequency? && salary_below_frequency_threshold?
    end

    def salary_below_pension_limit?
      salary < opt_in_lower_limit
    end

    def above_max_contribution?
      employee_contribution > TAX_RELIEF_MAX_CONTRIBUTION
    end

    private

    def valid_salary_frequency?
      TAX_RELIEF_THRESHOLDS.keys.include?(salary_frequency)
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
