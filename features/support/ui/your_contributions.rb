require_relative 'ui'

module UI
  class EmployeePercentSection < SitePrism::Page; end
  class EmployerPercentSection < SitePrism::Page; end

  class YourContributions < SitePrism::Page
    set_url '{/locale}/tools/wpcc/your_contributions'
    set_url_matcher(/wpcc\/\d+\/your_contributions/)

    element :details, '.details__row'
  end
end
