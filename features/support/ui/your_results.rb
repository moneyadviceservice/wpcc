require_relative 'ui'

module UI

  class YourResultsPage < SitePrism::Page
    set_url '{/locale}/tools/wpcc/your_results'
    
    element :details, '.details__row'
    element :contributions_summary, '.details__heading'
    element :percent_input, '.contributions__source-input'
  end
end
