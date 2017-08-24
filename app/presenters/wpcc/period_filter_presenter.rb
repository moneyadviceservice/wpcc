module Wpcc
  class PeriodFilterPresenter < Presenter
    def contribution_percents_explanation
      @second_period = periods[1]
      @last_period = periods.last

      if user_inputs_greater_than_legal_minimums?
        t('wpcc.results.large_contribution_percent_for_two_periods')
      elsif user_inputs_between_2nd_and_3rd_period_legal_minimums?
        t('wpcc.results.large_contribution_percent_for_middle_period')
      elsif user_input_for_employee_percent_greater_than_legal_minimums?
        t('wpcc.results.employee_large_contribution_percent_for_two_periods')
      elsif user_input_for_employer_percent_greater_than_legal_minimums?
        t('wpcc.results.employer_large_contribution_percent_for_two_periods')
      end
    end

    private

    def user_inputs_greater_than_legal_minimums?
      user_input_for_employee_percent_greater_than_legal_minimums? &&
        user_input_for_employer_percent_greater_than_legal_minimums?
    end

    def user_inputs_between_2nd_and_3rd_period_legal_minimums?
      user_input_employee_percent > @second_period.employee_percent &&
        user_input_employee_percent < @last_period.employee_percent &&
        user_input_employer_percent > @second_period.employer_percent &&
        user_input_employer_percent < @last_period.employer_percent
    end

    def user_input_for_employee_percent_greater_than_legal_minimums?
      user_input_employee_percent > @last_period.employee_percent
    end

    def user_input_for_employer_percent_greater_than_legal_minimums?
      user_input_employer_percent > @last_period.employer_percent
    end
  end
end
