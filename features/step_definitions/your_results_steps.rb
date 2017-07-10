Given(/^that I have completed the first of the WPCC tool$/) do
  # Step One - journey
  step 'I am on step 1 of the WPCC homepage'
  step 'I fill in the age, gender, salary and frequency fields'
  step 'I click on "My employer makes contributions on part of my salary"'
  step 'I click the Next button'
end

When(/^I have input % values on the second step$/) do
  # Step Two - journey
  # uses default values
end

When(/^I move on to the results page$/) do
  click_button
end

Then(/^I should see both of those values summarised next to the heading for the second step$/) do
  expect(page).to have_content('You: 1%, Your employer: 1%')
end
