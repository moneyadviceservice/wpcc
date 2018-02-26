module Wpcc
  class Period
    LEGAL_MINIMUM_CONTRIBUTION_PERCENT = 1

    include ActiveModel::Model
    include WpccConfig
    attr_accessor :name,
                  :employee_percent,
                  :employer_percent,
                  :tax_relief_percent,
                  :user_input_employee_percent,
                  :user_input_employer_percent

    def highest_employee_percent
      Percent.choose_highest(@employee_percent, @user_input_employee_percent)
    end

    def required_employer_percent(annual_salary)
      if salary_below_minimum?(annual_salary)
        @user_input_employer_percent
      else
        highest_employer_percent
      end
    end

    def should_be_filtered_out?(period_filter)
      percents_below_user_input_percents?(period_filter)
    end

    private

    def percents_below_user_input_percents?(period_filter)
      employee_percent <= period_filter.user_input_employee_percent &&
        employer_percent <= period_filter.user_input_employer_percent
    end

    def salary_below_minimum?(annual_salary)
      annual_salary < minimum_salary_threshold
    end

    def highest_employer_percent
      Percent.choose_highest(@employer_percent, @user_input_employer_percent)
    end

    def minimum_salary_threshold
      salary_threshold(:lower)
    end
  end
end
