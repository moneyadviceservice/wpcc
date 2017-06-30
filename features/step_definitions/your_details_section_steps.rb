Given(/^I am on step 1 of the WPCC homepage$/) do
  your_details_page.load
end

When(/^I fill in the age, gender, salary and frequency fields$/) do
  your_details_page.age.set 35
  your_details_page.genders.select('Female')
  your_details_page.salary.set 35000
  your_details_page.salary_frequencies.select('per Year')

  
end

And(/^I click on "My employer makes contributions on part of my salary"$/) do
  your_details_page.minimum_contribution_button.set true
end

And(/^I click on "My employer makes contributions on all of my salary"$/) do
  your_details_page.full_contribution_button.set true
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

Then(/^I should see in English\/Welsh my age, gender, salary, frequency and full pay$/) do
  expect(page).to have_content('35 years')
  expect(page).to have_content('female')
  expect(page).to have_content('£35000 year')
  expect(page).to have_content('full Contribution')
end
