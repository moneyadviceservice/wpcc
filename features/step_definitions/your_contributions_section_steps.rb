Then(/^I should see my contributions as "([^"]*)"$/) do |message|
  expect(your_results_page.your_contributions_information.text).to eq(message)
end
