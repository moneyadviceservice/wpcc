module Wpcc
  class PeriodContributionPresenter < SimpleDelegator
    delegate :t, :number_to_currency, to: :view_context

    attr_reader :object, :view_context

    def initialize(object, args = {})
      super(object)
      @view_context = args[:view_context]
      @object = object
    end

    def title
      t("wpcc.results.period_title.#{name}")
    end

    def employee_contribution
      formatted_contribution(object.employee_contribution)
    end

    def employer_contribution
      formatted_contribution(object.employer_contribution)
    end

    def tax_relief
      "(includes tax relief of #{formatted_contribution(object.tax_relief)})"
    end

    def total_contributions
      formatted_contribution(object.total_contributions)
    end

    private

    def formatted_contribution(contribution_value)
      number_to_currency(contribution_value, unit: '£', precision: 2)
    end
  end
end
