require_relative 'ui'

module UI
  class YourContributions < SitePrism::Page
    set_url '{/locale}/tools/wpcc/your_contributions'
    set_url_matcher(/wpcc\/\d+\/your_contributions/)
  end
end
