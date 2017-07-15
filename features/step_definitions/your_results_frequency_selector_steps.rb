When(/^I enter my age as 25$/) do
  your_details_page.age.set(25)
end

When(/^I enter my gender as male$/) do
  your_details_page.genders.select('Male')
end

When(/^My salary is 25000$/) do
  your_details_page.salary.set(25000)
end

When(/^I press next and move to your contributions step$/) do
  step 'I click the Next button'
end

When(/^I press next and move to your result step$/) do
  step 'I move to your results page'
end

When(/^I select "([^"]*)" salary frequency$/) do |salary_frequency|
  your_results_page.salary_frequencies.select(salary_frequency)
end

When(/^I press recalculate$/) do
  your_results_page.recalculate_button.click
end

Then(/^I should see an updated "([^"]*)" on the results page$/) do |arg1|
  expect(your_results_page).to have_content(arg1)
end
