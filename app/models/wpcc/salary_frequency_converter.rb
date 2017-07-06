module Wpcc
  class SalaryFrequencyConverter
    def self.convert(salary_frequency)
      salary_frequencies[salary_frequency]
    end

    def self.salary_frequencies
      {
        'year' => 1,
        'month' => 12,
        'fourweeks' => 13,
        'week' => 52
      }
    end

    private_class_method :salary_frequencies
  end
end
