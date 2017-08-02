module Wpcc
  class PeriodContributionPresenter < Presenter
    def title
      t("wpcc.results.period_title.#{name}")
    end

    def employee_contribution
      formatted_number(object.employee_contribution, '£')
    end

    def employer_contribution
      formatted_number(object.employer_contribution, '£')
    end

    def tax_relief
      "(includes tax relief of #{formatted_number(object.tax_relief, '£')})"
    end

    def total_contributions
      formatted_number(object.total_contributions, '£')
    end
  end
end
