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
