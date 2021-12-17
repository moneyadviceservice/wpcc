require_relative 'ui'

module UI
  class LandingPage < SitePrism::Page
    set_url '/'
    set_url_matcher(/wpcc\/\d+\/landing/)

    element :age, 'input[name="your_details_form[age]"]'
    element :salary, 'input[name="your_details_form[age]"]'
    element :minimum_contribution, 'input[name="your_details_form[age]"]'
    element :full_contribution, 'input[name="your_details_form[age]"]'
  end
end
