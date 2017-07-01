require 'active_model'

module Wpcc
  class ContributionCalculator
    include ActiveModel::Model

    UPPER_EARNINGS_THRESHOLD = 45_000
    LOWER_EARNINGS_THRESHOLD = 5_876

    attr_accessor :salary, :contribution_preference

    def initialize(salary, contribution_preference)
      @salary = salary
      @contribution_preference = contribution_preference
    end

    def calculate
      Wpcc::YourContribution.new(
        eligible_salary: eligible_salary,
        employee_percent: employee_percent,
        employer_percent: employer_percent
      )  
    end

    def eligible_salary
      raise NotImplementedError
    end

    def employee_percent
      raise NotImplementedError
    end

    def employer_percent
      raise NotImplementedError
    end

  end
end
