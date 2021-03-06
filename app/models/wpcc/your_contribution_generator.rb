module Wpcc
  class YourContributionGenerator
    include ActiveModel::Model

    CONTRIBUTION_PREFERENCE_TO_CLASS = {
      'minimum' => MinimumContributionCalculator,
      'full' => FullContributionCalculator
    }.freeze

    private_constant :CONTRIBUTION_PREFERENCE_TO_CLASS

    attr_accessor :contribution_preference, :salary_per_year
    delegate :employee_percent,
             :employer_percent,
             :eligible_salary,
             to: :contribution_calculator

    def contribution_calculator
      @contribution_calculator ||= contribution_klass.new(
        salary_per_year,
        contribution_preference
      )
    end

    private

    def contribution_klass
      CONTRIBUTION_PREFERENCE_TO_CLASS[contribution_preference]
    end
  end
end
