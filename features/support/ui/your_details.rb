require_relative 'ui'

module UI
  class YourDetails < SitePrism::Page
    set_url '/'
    set_url_matcher(/wpcc\/\d+\/your_details/)

    element :age, "input[name='your_details_form[age]']"
    element :genders, "select[name='your_details_form[gender]']"
    element :salary, "input[name='your_details_form[salary]']"
    element :salary_frequencies, "select[name='your_details_form[salary_frequency]']"
    # element :minimum_contribution_button, '#your_details_form_contribution_preference_minimum'
    # element :full_contribution_button, '#your_details_form_contribution_preference_full'


    element :next_button, "input[name='commit']"
  end
end