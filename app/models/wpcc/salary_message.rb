module Wpcc
  class SalaryMessage
    include ActiveModel::Model
    attr_accessor :salary, :salary_frequency, :employee_percent, :text

    THRESHOLDS_FILE = Wpcc::Engine.root.join(
      'config', 'salary_frequency_conversions.yml'
    ).freeze
    FREQUENCY_THRESHOLDS = YAML.load_file(THRESHOLDS_FILE).freeze
    OPT_IN_THRESHOLDS = FREQUENCY_THRESHOLDS['manual_opt_in_by_frequency'].freeze

    # OPT_IN_SALARY_LOWER_LIMIT = 5_876
    # OPT_IN_SALARY_UPPER_LIMIT = 10_000
    TAX_RELIEF_MAX_CONTRIBUTION = 40_000
    TAX_RELIEF_THRESHOLD_RATE = {
      year: 11_500,
      month: 958.33,
      fourweeks: 884.61,
      week: 221.15
    }.freeze

    def manually_opt_in?
      puts "\nsalary: #{salary}, salary_frequency: #{salary_frequency}\n"
      puts "\nOPTIN THRESHOLDS: #{OPT_IN_THRESHOLDS}, salary_frequency: #{salary_frequency}\n"
      puts "\n\nopt in upper: #{OPT_IN_THRESHOLDS['upper'].key(:year)} \n\n"
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
      TAX_RELIEF_THRESHOLD_RATE.keys.include?(salary_frequency.to_sym)
    end

    def salary_below_frequency_threshold?
      salary < TAX_RELIEF_THRESHOLD_RATE[salary_frequency.to_sym]
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
