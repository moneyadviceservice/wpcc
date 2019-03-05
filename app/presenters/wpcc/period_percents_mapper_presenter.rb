module Wpcc
  class PeriodPercentsMapperPresenter < Presenter
    def contribution_percents_explanation
      @period = map

      if user_inputs_greater_than_legal_minimums?
        t('wpcc.results.contribution_percentages_over_minimum')
      elsif user_input_for_employee_percent_greater_than_legal_minimums?
        t('wpcc.results.employee_contribution_percentage_over_minimum')
      elsif user_input_for_employer_percent_greater_than_legal_minimums?
        t('wpcc.results.employer_contribution_percentage_over_minimum')
      end
    end

    private

    def user_inputs_greater_than_legal_minimums?
      user_input_for_employee_percent_greater_than_legal_minimums? &&
        user_input_for_employer_percent_greater_than_legal_minimums?
    end

    def user_input_for_employee_percent_greater_than_legal_minimums?
      user_input_employee_percent >= @period.employee_percent
    end

    def user_input_for_employer_percent_greater_than_legal_minimums?
      user_input_employer_percent >= @period.employer_percent
    end
  end
end
