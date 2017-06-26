module Wpcc
  class PeriodContribution
    include ActiveModel::Model
    attr_accessor :name,
                  :employee_contribution,
                  :employer_contribution,
                  :total_contributions,
                  :tax_relief
  end
end
