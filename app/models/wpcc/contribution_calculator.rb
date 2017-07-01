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
      raise NotImplementedError
    end

  end
end
