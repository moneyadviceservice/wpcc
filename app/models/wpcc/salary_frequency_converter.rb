module Wpcc
  class SalaryFrequencyConverter
    CONVERSIONS = YAML.load_file(
      Wpcc::Engine.root.join('config', 'salary_frequency_conversions.yml')
    )
    SALARY_FREQUENCIES = CONVERSIONS['salary_frequencies']

    def self.convert(salary_frequency)
      SALARY_FREQUENCIES[salary_frequency]
    end
  end
end
