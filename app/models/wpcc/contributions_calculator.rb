require 'active_model'

module Wpcc
  class ContributionsCalculator
    include ActiveModel::Model

    UPPER_EARNINGS_THRESHOLD = 45_000
    LOWER_EARNINGS_THRESHOLD = 5_876

    attr_accessor :salary, :contribution_preference, :contributions

    def self.calculate(salary, contribution_preference)
      new(salary, contribution_preference).calculate
    end

    def initialize(salary, contribution_preference)
      @salary = salary
      @contribution_preference = contribution_preference
      @contributions = {}
    end

    def calculate
      case contribution_preference
      when 'minimum'
        then calculate_minimum_contribution
      when 'full'
        then calculate_full_contribution
      end
      contributions 
    end

    private

    def calculate_minimum_contribution
      return salary_gt_upper_earnings_threshold if salary > UPPER_EARNINGS_THRESHOLD
      return salary_lte_upper_earnings_threshold if salary <= UPPER_EARNINGS_THRESHOLD
    end

    def calculate_full_contribution
      salary_lt_lower_earnings_threshold if salary < LOWER_EARNINGS_THRESHOLD
      salary_lte_upper_earnings_threshold if salary >= LOWER_EARNINGS_THRESHOLD   
    end

    def salary_gt_upper_earnings_threshold
      puts '*' * 80
      puts 'case 1'
      puts '*' * 80
      contributions[:eligible_salary] = UPPER_EARNINGS_THRESHOLD - LOWER_EARNINGS_THRESHOLD
      contributions[:employee_contribution] = 0
      contributions[:employer_contribution] = 1
    end

    def salary_lte_upper_earnings_threshold
      puts '*' * 80
      puts 'case 2'
      puts '*' * 80
      contributions[:eligible_salary] = salary - LOWER_EARNINGS_THRESHOLD
      contributions[:employee_contribution] = 1
      contributions[:employer_contribution] = 1
    end

    def salary_lt_lower_earnings_threshold
      puts '*' * 80
      puts 'case 3'
      puts '*' * 80
      contributions[:eligible_salary] = salary
      contributions[:employee_contribution] = 1
      contributions[:employer_contribution] = 0
    end

    def salary_gte_lower_earnings_threshold
      puts '*' * 80
      puts 'case 4xs'
      puts '*' * 80
      contributions[:eligible_salary] = salary
      contributions[:employee_contribution] = 1
      contributions[:employer_contribution] = 1
    end
  end
end
