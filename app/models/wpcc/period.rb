module Wpcc
  class Period
    LEGAL_MINIMUM_CONTRIBUTION_PERCENT = 1

    include ActiveModel::Model
    attr_accessor :name,
                  :employee_percent,
                  :employer_percent,
                  :tax_relief_percent,
                  :user_input_employee_percent,
                  :user_input_employer_percent

    def highest_employee_percent
      Percent.choose_highest(@employee_percent, @user_input_employee_percent)
    end

    def required_employer_percent(eligible_salary)
      if salary_below_minimum?(eligible_salary)
        @user_input_employer_percent
      else
        highest_employer_percent
      end
    end

    def below_user_contributions?(period_filter)
      legal_minimum? && percents_below_user_input_percents?(period_filter)
    end

    private

    def legal_minimum?
      employee_percent.present?
    end

    def percents_below_user_input_percents?(period_filter)
      employee_percent <= period_filter.user_input_employee_percent &&
        employer_percent <= period_filter.user_input_employer_percent
    end

    def salary_below_minimum?(eligible_salary)
      eligible_salary < Wpcc::ContributionCalculator::THRESHOLDS['lower']
    end

    def highest_employer_percent
      Percent.choose_highest(@employer_percent, @user_input_employer_percent)
    end
  end
end
