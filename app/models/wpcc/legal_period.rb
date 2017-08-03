module Wpcc
  class LegalPeriod
    include ActiveModel::Model
    attr_accessor :name,
                  :employee_percent,
                  :employer_percent,
                  :tax_relief_percent
  end
end
