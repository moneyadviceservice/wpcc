module Wpcc
  class PeriodContributionPresenter < Presenter
    def title
      t("wpcc.results.period_title.#{name}")
    end

    def formatted_employee_contribution
      formatted_contribution(object.employee_contribution)
    end

    def formatted_employer_contribution
      formatted_contribution(object.employer_contribution)
    end

    def formatted_tax_relief
      "(includes tax relief of #{formatted_contribution(object.tax_relief)})"
    end

    def formatted_total_contributions
      formatted_contribution(object.total_contributions)
    end

    private

    def formatted_contribution(contribution_value)
      number_to_currency(contribution_value, unit: '£', precision: 2)
    end
  end
end
