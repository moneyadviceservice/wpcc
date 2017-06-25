require_relative 'ui'

module UI
  class EmployeePercentSection < SitePrism::Page; end
  class EmployerPercentSection < SitePrism::Page; end

  class YourContributionsPage < SitePrism::Page
    set_url '{/locale}/tools/wpcc/your_contributions'
    set_url_matcher(/wpcc\/\d+\/your_contributions/)

    section :employee_percent,   EmployeePercentSection, '.contributions__source--employee'
    section :employer_percent,   EmployerPercentSection, '.contributions__source--employer'

    element :details, '.details__row'
    element :contributions_description, '.t-contributions_description'
    element :percent_input, '.contributions__source-input'
  end
end
