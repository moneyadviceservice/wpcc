module Wpcc
  class SalaryMessage
    include ActiveModel::Model
    attr_accessor :salary, :salary_frequency, :message

    TAX_RELIEF_THRESHOLD_RATE = {
      year: 11_500,
      month: 958.33,
      fourweeks: 884.61,
      week: 221.15
    }.freeze

    def tax_relief_warning?
      message == :tax_relief_warning && salary_below_tax_relief_threshold?
    end

    private

    def salary_below_tax_relief_threshold?
      salary < TAX_RELIEF_THRESHOLD_RATE[salary_frequency.to_sym]
    end
  end
end
