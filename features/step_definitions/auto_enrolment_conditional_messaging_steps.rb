Given(/^that I am on the WPCC homepage in my own "([^"]*)"$/) do |language|
  your_details_page.load(language: 'cy')
end

When(/^I enter my personal details$/) do
  save_and_open_page
  your_details_page.age.set(35)
  your_details_page.genders.select('Female')
  your_details_page.salary_frequencies.select('per Year')
  your_details_page.minimum_contribution_button.set(true)
end

When(/^I enter a "([^"]*)" between the salary band$/) do |salary|
  your_details_page.salary.set(salary)
end

Then(/^I should see the auto\-enrolment "([^"]*)" in my own language$/) do |conditional_message|
  expect(page).to have_content(conditional_message)
end
