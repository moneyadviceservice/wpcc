module Wpcc
  module YourResultsHelper
    TAX_RELIEF_THRESHOLD_RATE = {
      year: 11_500,
      month: 958.33,
      fourweeks: 884.61,
      week: 221.15
    }.freeze

    def earning_below_tax_relief_threshold?(salary, salary_frequency)
      salary.to_f < TAX_RELIEF_THRESHOLD_RATE[salary_frequency.to_sym]
    end
  end
end
