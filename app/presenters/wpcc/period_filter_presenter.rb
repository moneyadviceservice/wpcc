module Wpcc
  class PeriodFilterPresenter < Presenter
    def contribution_percents_explanation
      second_period = periods[1]
      last_period = periods.last

      case
      when user_input_employee_percent > last_period.employee_percent &&
          user_input_employer_percent > last_period.employer_percent
        t('wpcc.results.large_contribution_percent_for_two_periods')
      when user_input_employee_percent > second_period.employee_percent &&
            user_input_employee_percent < last_period.employee_percent &&
              user_input_employer_percent > second_period.employer_percent &&
                user_input_employer_percent < last_period.employer_percent
        t('wpcc.results.large_contribution_percent_for_middle_period')
      when user_input_employee_percent > last_period.employee_percent
        t('wpcc.results.employee_large_contribution_percent_for_two_periods')
      when user_input_employer_percent > last_period.employer_percent
        t('wpcc.results.employer_large_contribution_percent_for_two_periods')
      end
    end
  end
end
