module Wpcc
  class YourContributionPresenter < Presenter
    def formatted_eligible_salary
      formatted_currency(object.eligible_salary, precision: 0)
    end

    def earnings_description
      t("wpcc.contributions.description_#{session[:contribution_preference]}",
        eligible_salary: formatted_eligible_salary)
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
