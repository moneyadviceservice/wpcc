Given(/^that I am on the WPCC homepage in my own "([^"]*)"$/) do |language|
  step 'that I am on the WPCC homepage'
end

When(/^I enter my personal details$/) do
  your_details_page.age.set(35)
  your_details_page.genders.select('Female')
  your_details_page.salary_frequencies.select('per Year')
  your_details_page.minimum_contribution_button.set(true)
end

When(/^I enter a "([^"]*)" between the salary band$/) do |salary|
  your_details_page.salary.set(salary)
end

Then(/^I should see the auto\-enrolment "([^"]*)"$/) do |conditional_message|
  expect(page).to have_content(conditional_message)
end

Then(/^I should see the information in my own "([^"]*)"$/) do |language|
  pending # Write code here that turns the phrase above into concrete actions
end
