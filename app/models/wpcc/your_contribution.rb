module Wpcc
  class YourContribution
    include ActiveModel::Model
    attr_accessor :eligible_salary,
                  :employee_percent,
                  :employer_percent
  end
end
