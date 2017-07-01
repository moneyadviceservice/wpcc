require 'active_model'

module Wpcc
  class CalculatorDelegator
    include ActiveModel::Model

    UPPER_EARNINGS_THRESHOLD = 45_000
    LOWER_EARNINGS_THRESHOLD = 5_876

    attr_accessor :salary, :contribution_preference

    def self.delegate(salary, contribution_preference)
      new(salary, contribution_preference).delegate
    end

    def initialize(salary, contribution_preference)
      @salary = salary
      @contribution_preference = contribution_preference
    end

    def delegate
      case contribution_preference
      when 'minimum'
        then MinimumContributionCalculator.new(
          salary, contribution_preference
        ).calculate
      when 'full'
        then FullContributionCalculator.new(
          salary, contribution_preference
        ).calculate
      else
        raise 'scream'
      end
    end
  end
end
