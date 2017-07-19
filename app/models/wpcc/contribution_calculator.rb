module Wpcc
  class ContributionCalculator
    THRESHOLDS_FILE = Wpcc::Engine.root.join('config', 'earning_thresholds.yml')
    THRESHOLDS = YAML.load_file(THRESHOLDS_FILE)

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

    protected

    def upper_earnings_threshold
      THRESHOLDS['upper']
    end

    def lower_earnings_threshold
      THRESHOLDS['lower']
    end
  end
end
