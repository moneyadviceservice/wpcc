require_relative 'ui'

module UI
  class YourDetails < SitePrism::Page
    set_url '/'
    set_url_matcher(/wpcc\/\d+\/your_details/)

    element :salary, '#your_details_form_salary'
    element :minimum_contribution, 'your_details_form_calculate_minimum'
  end
end
