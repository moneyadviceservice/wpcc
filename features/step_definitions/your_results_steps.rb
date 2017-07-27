When(/^I move on to the results page$/) do
  click_button
end

Then(/^I should see my employee contributions for current period as "([^"]*)"$/) do |employee_contribution|
  expect(your_results_page.current_period.employee_contribution.text).to eq(employee_contribution)
end

Then(/^I should see my tax relief for current period as "([^"]*)"$/) do |tax_relief|
  expect(your_results_page.current_period.tax_relief.text).to eq("(includes tax relief of #{tax_relief})")
end

Then(/^I should see my employer contributions for current period as "([^"]*)"$/) do |employer_contribution|
  expect(your_results_page.current_period.employer_contribution.text).to eq(employer_contribution)
end

Then(/^I should see my total contributions for current period as "([^"]*)"$/) do |total_contributions|
  expect(your_results_page.current_period.total_contributions.text).to eq(total_contributions)
end

Then(/^I should see my employee contributions for second period as "([^"]*)"$/) do |employee_contribution|
  next if your_results_page.has_no_second_period?

  expect(your_results_page.second_period.employee_contribution.text).to eq(employee_contribution)
end

Then(/^I should see my employer contributions for second period as "([^"]*)"$/) do |employer_contribution|
  next if your_results_page.has_no_second_period?

  expect(your_results_page.second_period.employer_contribution.text).to eq(employer_contribution)
end

Then(/^I should see my tax relief for second period as "([^"]*)"$/) do |tax_relief|
  next if your_results_page.has_no_second_period?

  expect(your_results_page.second_period.tax_relief.text).to eq("(includes tax relief of #{tax_relief})")
end

Then(/^I should see my total contributions for second period as "([^"]*)"$/) do |total_contributions|
  next if your_results_page.has_no_second_period?

  expect(your_results_page.second_period.total_contributions.text).to eq(total_contributions)
end

Then(/^I should see my employee contributions for third period as "([^"]*)"$/) do |employee_contribution|
  expect(your_results_page.third_period.employee_contribution.text).to eq(employee_contribution)
end

Then(/^I should see my employer contributions for third period as "([^"]*)"$/) do |employer_contribution|
  expect(your_results_page.third_period.employer_contribution.text).to eq(employer_contribution)
end

Then(/^I should see my tax relief for third period as "([^"]*)"$/) do |tax_relief|
  expect(your_results_page.third_period.tax_relief.text).to eq("(includes tax relief of #{tax_relief})")
end

Then(/^I should see my total contributions for third period as "([^"]*)"$/) do |total_contributions|
  expect(your_results_page.third_period.total_contributions.text).to eq(total_contributions)
end

Given(/^that I am on the WPCC homepage in my own "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  your_details_page.load(locale: locale)
end

When(/^I enter my personal details$/) do
  your_details_page.age.set(35)
  your_details_page.genders.select(
    I18n.translate('wpcc.details.options.gender.female')
  )
  your_details_page.minimum_contribution_button.set(true)
end

When(/^I progress to the results page$/) do
  step 'I move to your results page'
end

Then(/^I should see tax relief "([^"]*)"$/) do |warning_message|
  expect(page).to have_content(warning_message)
end

def language_to_locale(language)
  { 'English' => :en, 'Welsh' => :cy }[language]
end
