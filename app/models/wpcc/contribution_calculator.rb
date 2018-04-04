module Wpcc
  class ContributionCalculator
    include WpccConfig

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

    def upper_salary_threshold
      salary_threshold(:upper)
    end

    def lower_salary_threshold
      salary_threshold(:lower)
    end

    protected

    def percentage(contributor)
      current_min_contribution_percentage_for(contributor, limit)
    end

    private

    def limit
      below_threshold? ? 'below_threshold' : 'above_threshold'
    end
  end
end
