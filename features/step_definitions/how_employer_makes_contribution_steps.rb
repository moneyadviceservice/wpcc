Given(/^that I am on the WPCC homepage$/) do
  your_details_page.load
end

When(/^I enter my details$/) do
  your_details_page.age.set(35)
  your_details_page.genders.select('Female')
end

When(/^I enter a "([^"]*)" below the minimum threshold$/) do |salary|
  your_details_page.salary.set(salary)
end

When(/^I enter a salary below the minimum threshold$/) do
  your_details_page.salary.set(5000)
end

When(/^I select a valid "([^"]*)"$/) do |salary_frequency|
  your_details_page.salary_frequencies.select(salary_frequency)
end

When(/^I choose to make minimum contributions$/) do
  your_details_page.minimum_contribution_button.set true
end

When(/^I submit my details$/) do
  your_details_page.next_button.click
end

Then(/^I should not be able to choose to make minimum employer contributions$/) do
  minimum_option_radio= 'your_details_form_contribution_preference_minimum'

  expect(page.find_by_id(minimum_option_radio).disabled?).to be_truthy
end

When(/^I choose to make full contributions$/) do
  your_details_page.full_contribution_button.set true
end

Then(/^I should be able to proceed to the next page$/) do
  expect(page.current_url).to have_content('/your_contributions/new')
end
