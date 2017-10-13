module Wpcc
  module EarningsDescription
    def formatted_eligible_salary
      formatted_currency(object.eligible_salary, precision: 0)
    end

    def earnings_description(opts = {})
      contribution_preference = session[:contribution_preference]
      description_key = earnings_description_key

      t(
        "wpcc.#{description_key}.description_#{contribution_preference}_html",
        eligible_salary: formatted_eligible_salary,
        tooltip_html: opts[:tooltip_html]
      )
    end

    def earnings_description_key
      raise NotImplementedError
    end
  end
end
