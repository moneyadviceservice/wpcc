require_relative 'ui'

module UI
  class YourContributionsPage < SitePrism::Page
    set_url '/{locale}/tools/workplace-pension-contribution-calculator/your_contributions/new'

    element :form, "#new_your_contributions_form"
    element :employee_percent, 'input[name="your_contributions_form[employee_percent]"]'
    element :employer_percent, 'input[name="your_contributions_form[employer_percent]"]'

    element :details, '.details__row'
    element :contributions_description, '.t-contributions_description'
    element :percent_input, '.contributions__source-input'
    element :calculate_your_contributions_button, 'input[type="submit"]'
    element :edit_link, '.details__heading a'
    element :next_button, "input[type='submit']"
  end
end
