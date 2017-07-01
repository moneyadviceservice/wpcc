module Wpcc
  class CalculatorDelegator
    include ActiveModel::Model

    attr_accessor :salary, :contribution_preference

    def self.delegate(salary, contribution_preference)
      new(salary, contribution_preference).delegate
    end

    def initialize(salary, contribution_preference)
      @salary = salary
      @contribution_preference = contribution_preference
    end

    def delegate
      contribution_klass.new(salary,
                             contribution_preference).calculate
    end

    private

    def contribution_klass
      CONTRIBUTION_PREFERENCE_TO_CLASS[contribution_preference]
    end

    CONTRIBUTION_PREFERENCE_TO_CLASS = {
      'minimum' => MinimumContributionCalculator,
      'full' => FullContributionCalculator
    }.freeze
  end
end
