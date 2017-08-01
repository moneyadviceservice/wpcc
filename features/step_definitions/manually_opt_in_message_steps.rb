When(/^I enter my age "([^"]*)" and "([^"]*)"$/) do |gender, salary_frequency|
  your_details_page.age.set(35)
  your_details_page.genders.select(gender)
  your_details_page.salary_frequencies.select(salary_frequency)
end

When(/^I choose to make the minimum contribution$/) do
  your_details_page.minimum_contribution_button.set(true)
end

When(/^I choose to make the full contribution$/) do
  your_details_page.full_contribution_button.set(true)
end

When(/^I enter a "([^"]*)" between the salary band$/) do |salary|
  your_details_page.salary.set(salary)
end

When(/^I enter a "([^"]*)" above the upper salary threshold$/) do |salary|
  your_details_page.salary.set(salary)
end

When(/^I enter a "([^"]*)" below the low salary threshold$/) do |salary|
  your_details_page.salary.set(salary)
end

When(/^I enter my details with a salary within manually_opt_in range and submit the form$/) do
  your_details_page.age.set(35)
  your_details_page.genders.select('Male')
  your_details_page.salary.set(8_500)
  your_details_page.salary_frequencies.select('per Year')
  your_details_page.minimum_contribution_button.set(true)
  your_details_page.next_button.click
end

When(/^I submit the Your Contributiions form and proceed to Your Results$/) do
  your_contributions_page.next_button.click
end

Then(/^I should see the manually_opt_in "([^"]*)" in my own language$/) do |message|
  expect(page).to have_content(message)
end

Then(/^I should not see the manually_opt_in "([^"]*)"$/) do |message|
  expect(page).to_not have_content(message)
end
