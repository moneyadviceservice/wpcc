module World
  module WaitForPageLoad
    def wait_for_page_load(current_page)
      return unless @javascript

      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until finished_all_js_requests?(current_page)
      end
    end

    def finished_all_js_requests?(current_page)
      case current_page
      when 'your_results'
        page.html.include?('data-dough-update-results-initialised')
      when 'your_contributions'
        page.html.include?('data-dough-contribution-conditions-initialised')
      when 'your_details'
        page.html.include?('data-dough-validation-initialised')
      end
    end
  end
end
World(World::WaitForPageLoad)