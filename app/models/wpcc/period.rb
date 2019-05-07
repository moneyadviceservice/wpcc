module Wpcc
  class Period
    include ActiveModel::Model
    include WpccConfig

    LEGAL_MINIMUM_CONTRIBUTION_PERCENT = 1

    attr_accessor :name,
                  :employee_percent,
                  :employer_percent,
                  :tax_relief_percent,
                  :user_input_employee_percent,
                  :user_input_employer_percent
  end
end
