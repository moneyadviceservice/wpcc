module Wpcc
  class YourContribution
    include ActiveModel::Model
    attr_accessor :eligible_salary,
                  :employee_percent,
                  :employer_percent

    CONTRIBUTION_PREFERENCES = {
      'minimum' => MinimumContributionCalculator,
      'full' => FullContributionCalculator
    }.freeze

    def self.generate(salary, contribution_preference)
      contribution_klass = CONTRIBUTION_PREFERENCES[contribution_preference]
      calculator = contribution_klass.new(salary, contribution_preference)
      new(
        eligible_salary:  calculator.eligible_salary,
        employee_percent: calculator.employee_percent,
        employer_percent: calculator.employer_percent
      )
    end
  end
end
