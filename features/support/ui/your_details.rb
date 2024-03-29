require_relative 'ui'

module UI
  class YourDetailsPage < SitePrism::Page
    set_url '/{language_code}/tools/workplace-pension-contribution-calculator'

    element :form, "#new_your_details_form"
    element :age, "input[name='your_details_form[age]']"
    element :salary, "input[name='your_details_form[salary]']"
    element :salary_frequencies, "select[name='your_details_form[salary_frequency]']"
    element :minimum_contribution_button, '#your_details_form_contribution_preference_minimum'
    element :full_contribution_button, '#your_details_form_contribution_preference_full'
    element :salary_below_threshold_callout, '[data-wpcc-callout-below-part-contributions-threshold]'
    element :next_button, "input[type='submit']"
  end
end
