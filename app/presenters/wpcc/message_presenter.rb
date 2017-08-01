module Wpcc
  class MessagePresenter < Presenter
    def manually_opt_in_message?
      text == :manually_opt_in && manually_opt_in?
    end

    def manually_opt_in_message
      t('wpcc.contributions.manually_opt_in')
    end

    def tax_relief_warning?
      salary_below_tax_relief_threshold?
    end

    def tax_relief_warning
      t('wpcc.results.tax_relief_warning_html')
    end
  end
end
