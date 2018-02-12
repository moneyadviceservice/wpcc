module Wpcc
  class ContributionCalculator
    CONFIG = ::Wpcc::ConfigLoader.load('contribution_calculations')

    attr_accessor :salary_per_year, :contribution_preference

    def initialize(salary_per_year, contribution_preference)
      @salary_per_year = salary_per_year
      @contribution_preference = contribution_preference
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

    def below_threshold?
      raise NotImplementedError
    end

    def upper_earnings_threshold
      CONFIG['salary_thresholds']['upper']
    end

    def lower_earnings_threshold
      CONFIG['salary_thresholds']['lower']
    end

    protected

    def percentage(type)
      CONFIG[contribution_preference][type][key]
    end

    private

    def key
      below_threshold? ? 'below_threshold' : 'above_threshold'
    end
  end
end
