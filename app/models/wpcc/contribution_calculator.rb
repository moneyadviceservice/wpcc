require 'active_model'

module Wpcc
  class ContributionCalculator
    include ActiveModel::Model

    THRESHOLDS_FILE = Wpcc::Engine.root.join('config', 'earning_thresholds.yml')
    THRESHOLDS = YAML.load_file(THRESHOLDS_FILE)

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

    protected

    def upper_earnings_threshold
      THRESHOLDS['upper']
    end

    def lower_earnings_threshold
      THRESHOLDS['lower']
    end
  end
end
