Given(/^I am on the YourDetailsPage$/) do
  your_details_page.load
end

When(/^my salary per year is equal to or less than the upper earnings threshold of £45,000$/) do
  fill_in :salary, with: 35000
end

And(/^I select the minimum contribution on Step 1$/) do
  choose 'your_details_form_calculate_minimum'
end

And(/^I press next$/) do
  click_button("next")
end

Then(/the Step 2 intro paragraph should display my eligible salary$/) do

end
