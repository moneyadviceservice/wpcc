Given(/^I am on step 1 of the WPCC homepage$/) do
  locale = language_to_locale(language = 'English')

  your_details_page.load(locale: locale)
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

When(/^I fill in my details$/) do
  step 'I fill in the age, gender, salary and frequency fields'
  step 'I click on "My employer makes contributions on part of my salary"'
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
  your_details_page.minimum_contribution_button.set(true)
end

When(/^I submit my details$/) do
  your_details_page.next_button.click
end

Then(/^I should not be able to choose to make minimum employer contributions$/) do
  expect(your_details_page.minimum_contribution_button).to be_disabled
end

When(/^I choose to make full contributions$/) do
  your_details_page.full_contribution_button.set(true)
end

Then(/^I should be able to proceed to the next page$/) do
  expect(page.current_url).to have_content('/your_contributions/new')
end

Given(/^I am on the YourDetailsPage$/) do
  step 'I am on step 1 of the WPCC homepage'
end

When(/^I enter my age as 35$/) do
  your_details_page.age.set(35)
end

When(/^I enter my gender as female$/) do
  your_details_page.genders.select('Female')
end

When(/^my salary per year is equal to or less than the upper earnings threshold of £45,000$/) do
  your_details_page.salary.set(35000)
end

When(/^my salary per year is greater than the upper earnings threshold of £45,000$/) do
  your_details_page.salary.set(50000)
end

When(/^I select per Year salary frequency$/) do
  your_details_page.salary_frequencies.select('per Year')
end

When(/^I select the minimum contribution$/) do
  your_details_page.minimum_contribution_button.set(true)
end

When(/^I press next$/) do
  your_details_page.next_button.click
end

Then(/^the Step 2 intro paragraph should display my eligible salary$/) do
  expect(your_contributions_page.contributions_description).to have_content(29124)
end

Then(/^the Step 2 intro paragraph should calc my eligible salary$/) do
  expect(your_contributions_page.contributions_description).to have_content(39124)
end

Then(/^the employee_percent input intro paragraph should display the correct percentage$/) do
  within('.contributions__source--employee') do
    expect(your_contributions_page).to have_content('The legal minimum is 1%')
  end
end

Then(/^the employer_percent input intro paragraph should display the correct percentage$/) do
  within('.contributions__source--employer') do
    expect(your_contributions_page).to have_content('The legal minimum is 1%')
  end
end
