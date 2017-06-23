module Wpcc
  class PeriodContribution
    attr_reader :eligible_salary, :salary_frequency
    attr_reader :employee_percent, :employer_percent

    def initialize(eligible_salary, 
                   employee_percent, 
                   employer_percent, 
                   salary_frequency)

      @eligible_salary = eligible_salary
      @employee_percent = employee_percent
      @employer_percent = employer_percent
      @salary_frequency = salary_frequency
    end

  end
end
