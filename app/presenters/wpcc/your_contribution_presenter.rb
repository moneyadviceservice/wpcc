module Wpcc
  class YourContributionPresenter < Presenter
    include ::Wpcc::EarningsDescription

    def earnings_description_key
      'contributions'
    end
  end
end
