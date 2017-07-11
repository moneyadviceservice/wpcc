Given(/^I am on the WPCC homepage$/) do
  step 'I am on step 1 of the WPCC homepage'
end

Given(/^I complete the first step and move on to second step$/) do
  step 'I fill in the age, gender, salary and frequency fields'
  step 'I click on "My employer makes contributions on part of my salary"'
  step 'I click the Next button'
end

When(/^I click edit on the first step section$/) do
  find_link('edit').click
end

Then(/^I should return to the first step$/) do
  expect(page).to have_css('#new_your_details_form')
end

Then(/^I should see my details in the form fields$/) do
  expect(page).to have_css("input[value='35']")
  expect(page).to have_css("input[value='35000']")
  expect(page).to have_css("input[value='minimum']")
end
