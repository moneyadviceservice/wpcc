module Wpcc
  class PeriodPresenter < Presenter
    def title
      t("wpcc.results.period_percents_title.#{name}")
    end

    def employee_percent
      format_percentage(object.employee_percent)
    end

    def employer_percent
      format_percentage(object.employer_percent)
    end

    private

    def format_percentage(number)
      number ||= Wpcc::Period::LEGAL_MINIMUM_CONTRIBUTION_PERCENT
      view_context.number_to_percentage(number, precision: 0).to_s
    end
  end
end
