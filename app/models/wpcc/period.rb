module Wpcc
  class Period
    include ActiveModel::Model
    attr_accessor :name,
                  :employee_percent,
                  :employer_percent,
                  :tax_relief_percent,
                  :user_input_employee_percent,
                  :user_input_employer_percent

    def employee_percent
      Percent.choose_highest(@employee_percent, @user_input_employee_percent)
    end

    def employer_percent
      Percent.choose_highest(@employer_percent, @user_input_employer_percent)
    end
  end
end
