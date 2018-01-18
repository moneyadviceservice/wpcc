module Wpcc
  class SalaryFrequencyConverter
    CONVERSIONS = ::Wpcc::ConfigLoader.load('salary_frequency_conversions')
    SALARY_FREQUENCIES = CONVERSIONS['salary_frequencies']

    def self.convert(salary_frequency)
      SALARY_FREQUENCIES[salary_frequency]
    end

    def self.adjectives
      CONVERSIONS['adjectives']
    end
  end
end
