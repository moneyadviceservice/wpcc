module Wpcc
  class SalaryFrequencyConverter
    extend WpccConfig
    SALARY_FREQUENCIES = frequency_conversions['salary_frequencies']

    def self.convert(salary_frequency)
      SALARY_FREQUENCIES[salary_frequency]
    end
  end
end
