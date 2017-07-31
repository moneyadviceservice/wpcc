module Wpcc
  class PeriodContributionCalculatorPresenter < Presenter
    def title
      t("wpcc.results.period_percents_title.#{name}")
    end

    def employee_percent
      formatted_number(object.employee_percent, '%')
    end

    def employer_percent
      formatted_number(object.employer_percent, '%')
    end
  end
end
