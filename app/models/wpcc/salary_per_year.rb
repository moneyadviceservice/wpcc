module Wpcc
  class SalaryPerYear
    include ActiveModel::Model
    attr_accessor :salary, :salary_frequency

    def convert
      salary.to_i * SalaryFrequencyConverter.convert(salary_frequency)
    rescue StandardError
      raise("Salary frequency '#{salary_frequency}' is not supported.")
    end
  end
end

