Given(/^I am on the WPCC homepage$/) do
  step 'I am on step 1 of the WPCC homepage'
end

Given(/^I complete the your contributions form$/) do
  # using default values for employee and employer percents
end

Given(/^I move to your results page$/) do
  your_contributions_page.next_button.click
end

Given(/^I complete the your details form and move to your contributions page$/) do
  step 'I fill in the age, gender, salary and frequency fields'
  step 'I click on "My employer makes contributions on part of my salary"'
  step 'I click the Next button'
end

Given(/^my contribution is "([^"]*)" percent$/) do |contribution|
  step %{my employee contribution is "#{contribution}"}
end

Given(/^I fill in my contributions:$/) do |table|
  data = table.hashes.first
  step %{my employee contribution is "#{data[:your_contribution]}"}
  step %{my employer contribution is "#{data[:employer_contribution]}"}
end

Given(/^my employee contribution is "([^"]*)"$/) do |employee_percent|
  your_contributions_page.employee_percent.set(employee_percent)
end

Given(/^my employer contribution is "([^"]*)"$/) do |employer_percent|
  your_contributions_page.employer_percent.set(employer_percent)
end

Given(/^I have valid contributions$/) do
  step 'I fill in my employer and employee contributions'
  step 'I click the Next button'
end

When(/^I fill in my employer and employee contributions$/) do
  your_contributions_page.employee_percent.set(14)
  your_contributions_page.employer_percent.set(15)
end

When(/^I click to edit my details$/) do
  your_contributions_page.edit_link.click
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

Then(/^I should return to the Your Details step$/) do
  expect(your_details_page.form).to be_visible
end

Then(/^I should see my current details in the form fields$/) do
  expect(page).to have_css("input[value='35']")
  expect( find(:css, 'select#your_details_form_gender').value ).to eq('female')
  expect(page).to have_css("input[value='35000']")
  expect( find(:css, 'select#your_details_form_salary_frequency').value ).to eq('year')
  expect(page).to have_css("input[value='minimum']")
end

When(/^I click to edit my contributions$/) do
  your_results_page.your_contributions_edit.click
end

Then(/^the employee percent input should be "([^"]*)"$/) do |employee_percent|
  expect(your_contributions_page.employee_percent.value).to eq(employee_percent)
end

Then(/^the employer percent input should be "([^"]*)"$/) do |employer_percent|
  expect(your_contributions_page.employer_percent.value).to eq(employer_percent)
end

Then(/^I should see my contributions as "([^"]*)"$/) do |message|
  expect(your_results_page.your_contributions_information.text).to eq(message)
end
