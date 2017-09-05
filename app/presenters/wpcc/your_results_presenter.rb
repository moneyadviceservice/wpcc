module Wpcc
  class YourResultsPresenter < ::Wpcc::Presenter
    include ::Wpcc::EarningsDescription

    def earnings_description_key
      'results'
    end
  end
end
