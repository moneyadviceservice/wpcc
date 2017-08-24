module Wpcc
  class YourContributionPresenter < Presenter
    def formatted_eligible_salary
      formatted_currency(object.eligible_salary, precision: 0)
    end

    def earnings_description
      t("wpcc.contributions.description_#{session[:contribution_preference]}",
        eligible_salary: formatted_eligible_salary)
    end
  end
end
