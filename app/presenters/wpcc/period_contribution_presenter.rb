module Wpcc
  class PeriodContributionPresenter < Presenter
    def title
      t("wpcc.results.period_title.#{name}")
    end

    def employee_contribution
      formatted_currency(object.employee_contribution)
    end

    def employer_contribution
      formatted_currency(object.employer_contribution)
    end

    def tax_relief
      "(includes tax relief of #{formatted_currency(object.tax_relief)})"
    end

    def total_contributions
      formatted_currency(object.total_contributions)
    end
  end
end
