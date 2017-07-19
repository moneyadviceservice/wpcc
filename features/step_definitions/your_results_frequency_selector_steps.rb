When(/^I press next and move to your contributions step$/) do
  step 'I click the Next button'
end

When(/^I press next and move to your result step$/) do
  step 'I move to your results page'
end

When(/^I select "([^"]*)" to change the calculations$/) do |salary_frequency|
  your_results_page.salary_frequencies.select(salary_frequency)
end

When(/^I press recalculate$/) do
  your_results_page.recalculate_button.click
end
