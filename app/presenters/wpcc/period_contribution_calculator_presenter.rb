module Wpcc
  class PeriodContributionCalculatorPresenter < Presenter
    def title
      t("wpcc.results.period_title.#{name}")
    end

    def employee_percent
      formatted_percent(object.employee_percent)
    end

    def employer_percent
      formatted_percent(object.employer_percent)
    end

    private

    def formatted_percent(percent_value)
      number_to_currency(percent_value, unit: '%', precision: 2)
    end
  end
end
