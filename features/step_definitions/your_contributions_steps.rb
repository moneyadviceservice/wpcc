Given(/^I am on the Your Contributions step$/) do
  your_contributions_page.load(locale: language)
end

Given(/^I have valid contributions$/) do
  step 'I fill in my employer and employee contributions'
  step 'I click the Next button'
end

When(/^my employee contribution is "([^"]*)"$/) do |employee_percent|
  your_contributions_page.employee_percent.set(employee_percent)
end

When(/^my employer contribution is "([^"]*)"$/) do |employer_percent|
  your_contributions_page.employer_percent.set(employer_percent)
end

When(/^my contribution is "([^"]*)" percent$/) do |contribution|
  step %{my employee contribution is "#{contribution}"}
end

When(/^I fill in my employer and employee contributions$/) do
  step %{my employee contribution is "14"}
  step %{my employer contribution is "15"}
end

When(/^I fill in my contributions:$/) do |table|
  data = table.hashes.first
  step %{my employee contribution is "#{data[:your_contribution]}"}
  step %{my employer contribution is "#{data[:employer_contribution]}"}
end

When(/^I click to edit my details$/) do
  your_contributions_page.edit_link.click
end

When(/^I move( on)? to (your|the) results page$/) do |_,_|
  your_contributions_page.next_button.click
end

When(/^I submit the Your Contributiions form and proceed to Your Results$/) do
  step 'I move to your results page'
end

When(/^I press next and move to your result step$/) do
  step 'I move to your results page'
end

Then(/^I should see my contributions summarised$/) do
  expect(your_results_page.your_contributions_information.text).to eq('You: 14%, Your employer: 15%')
end

Then(/^I should return to the Your Contributions step$/) do
  expect(your_contributions_page.form).to be_visible
end

Then(/^I should see my current contributions in the form fields$/) do
  expect(your_contributions_page.employee_percent.value).to eq('14')
  expect(your_contributions_page.employer_percent.value).to eq('15')
end