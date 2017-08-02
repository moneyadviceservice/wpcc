require_relative 'ui'

module UI
  class PeriodSection < SitePrism::Section
    element :employee_contribution, '.results__period-employee-contribution'
    element :tax_relief, '.results__period-tax-relief'
    element :employer_contribution, '.results__period-employer-contribution'
    element :total_contributions, '.results__period-total-contributions'
  end

  class YourResultsPage < SitePrism::Page
    set_url '{/locale}/tools/wpcc/your_results'

    element :details, '.details__row'
    element :contributions_summary, '.details__heading'
    element :percent_input, '.contributions__source-input'
    element :your_contributions_edit, '.contributions__heading a'
    element :your_contributions_information, '.section--contributions .section__heading-summary'

    element :salary_frequencies, "select[name='salary_frequency']"
    element :recalculate_button, "input[type='submit']"

    section :current_period, PeriodSection, '.results__period-april_2017_march_2018'
    section :second_period, PeriodSection, '.results__period-april_2018_march_2019'
    section :third_period, PeriodSection, '.results__period-after_april_2019'

    # element :results_heading , 'results__period-heading'
  end
end
