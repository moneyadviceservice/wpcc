module Wpcc
  class YourContributionPresenter < Presenter
    def formatted_eligible_salary
      formatted_currency(object.eligible_salary)
    end

    def upper_earnings_threshold
      formatted_currency(
        Wpcc::ContributionCalculator::THRESHOLDS['upper'],
        precision: 0
      )
    end

    def lower_earnings_threshold
      formatted_currency(
        Wpcc::ContributionCalculator::THRESHOLDS['lower'],
        precision: 0
      )
    end
  end
end
