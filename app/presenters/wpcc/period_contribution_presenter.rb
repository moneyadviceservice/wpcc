module Wpcc
  class PeriodContributionPresenter < Presenter
    def title
      t("wpcc.results.period_title.#{name}")
    end

    def employee_contribution
      formatted_contribution(object.employee_contribution)
    end

    def employee_contribution_data
      object.employee_contribution
    end

    def employer_contribution
      formatted_contribution(object.employer_contribution)
    end

    def employer_contribution_data
      object.employer_contribution
    end

    def tax_relief
      "(includes tax relief of #{formatted_contribution(object.tax_relief)})"
    end

    def tax_relief_data
      object.tax_relief
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
