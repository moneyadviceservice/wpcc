module Wpcc
  class MessagePresenter < Presenter
    def tax_relief_warning?
      salary_below_tax_relief_threshold?
    end

    def tax_relief_warning
      t('wpcc.results.tax_relief_warning_html')
    end
  end
end
