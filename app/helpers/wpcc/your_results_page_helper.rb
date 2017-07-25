module Wpcc
  module YourResultsPageHelper
    TAX_RELIEF_THRESHOLD_RATE = 11_500

    def earning_below_tax_relief_threshold?(salary)
      salary.to_i < TAX_RELIEF_THRESHOLD_RATE
    end
  end
end
