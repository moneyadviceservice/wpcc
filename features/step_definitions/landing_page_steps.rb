When(/^I visit the LandingPage$/) do
  landing_page.load
end

Then(/^I want to be able to input my age$/) do
  expect(landing_page.age).to be_truthy
end

And(/^I want to be able to input my gender$/) do
  expect(landing_page.gender).to be_truthy
end

And(/^I want to be able to input my salary$/) do
  expect(landing_page.salary).to be_truthy
end

And(/^I want to select my employer contributions$/) do
  expect(landing_page.minimum_contribution).to be_truthy
  expect(landing_page.full_contribution).to be_truthy
end
