Given(/^I am on step 1 of the WPCC homepage$/) do
  your_details_page.load
end

Given(/^I enter my age as "([^"]*)"$/) do |age|
  your_details_page.age.set(age)
end

Given(/^I select my gender as "([^"]*)"$/) do |gender|
  your_details_page.genders.select(gender.capitalize)
end

Given(/^I enter my salary as "([^"]*)"$/) do |salary|
  your_details_page.salary.set(salary)
end

Given(/^I select my salary frequency as "([^"]*)"$/) do |salary_frequency|
  your_details_page.salary_frequencies.select(salary_frequency)
end

Given(/^I choose my contribution preference as "([^"]*)"$/) do |contribution_preference|
  your_details_page.send("#{contribution_preference.downcase}_contribution_button").set(true)
end

When(/^I fill in the age, gender, salary and frequency fields$/) do
  your_details_page.age.set(35)
  your_details_page.genders.select('Female')
  your_details_page.salary.set(35000)
  your_details_page.salary_frequencies.select('per Year')
end

And(/^I click on "My employer makes contributions on part of my salary"$/) do
  your_details_page.minimum_contribution_button.set(true)
end

And(/^I click on "My employer makes contributions on all of my salary"$/) do
  your_details_page.full_contribution_button.set(true)
end

And(/^I click the Next button$/) do
  your_details_page.next_button.click
end

Then(/^I should see my age, gender, salary, frequency and contribution option$/) do
  expect(page).to have_content('35 years')
  expect(page).to have_content('female')
  expect(page).to have_content('£35000 year')
  expect(page).to have_content('minimum Contribution')
end

Then(/^I should see in English my age, gender, salary, frequency and full pay$/) do
  expect(page).to have_content('35 years')
  expect(page).to have_content('female')
  expect(page).to have_content('£35000 year')
  expect(page).to have_content('full Contribution')
end
