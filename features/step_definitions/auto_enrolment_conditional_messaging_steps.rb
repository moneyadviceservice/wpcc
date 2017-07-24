Given(/^that I am on the WPCC homepage in my own "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  your_details_page.load(locale: locale)
end

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

Then(/^I should see the auto\-enrolment "([^"]*)" in my own language$/) do |conditional_message|
  expect(page).to have_content(conditional_message)
end

Then(/^I should not see the auto\-enrolment "([^"]*)"$/) do |conditional_message|
  expect(page).to_not have_content(conditional_message)
end
