Given(/^that I am on the WPCC homepage in my own "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  your_details_page.load(locale: locale)
end

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

Then(/^I should NOT see tax relief "([^"]*)"$/) do |warning_message|
  expect(page).to_not have_content(warning_message)
end

Given(/^that I am on your details step I fill:$/) do |table|
  data = table.hashes.first
  step %{I enter my age as "#{data[:age]}"}
  step %{I select my gender as "#{data[:gender]}"}
  step %{I enter my salary as "#{data[:salary]}"}
  step %{I select my salary frequency as "#{data[:salary_frequency]}"}
  step %{I choose my contribution preference as "#{data[:contribution]}"}
end

Given(/^that on your contributions step I fill:$/) do |table|
  data = table.hashes.first
  step %{my employee contribution is "#{data[:your_contribution]}"}
  step %{my employer contribution is "#{data[:employer_contribution]}"}
end

Then(/^I should see on the results page:$/) do |table|
  data = table.transpose.raw
  current_period = data[0]
  second_period = data[1]
  third_period = data[2]

  step %{I should see my employee contributions for current period as "#{current_period[0]}"}
  step %{I should see my tax relief for current period as "#{current_period[1]}"}
  step %{I should see my employer contributions for current period as "#{current_period[2]}"}
  step %{I should see my total contributions for current period as "#{current_period[3]}"}

  step %{I should see my employee contributions for second period as "#{second_period[0]}"}
  step %{I should see my tax relief for second period as "#{second_period[1]}"}
  step %{I should see my employer contributions for second period as "#{second_period[2]}"}
  step %{I should see my total contributions for second period as "#{second_period[3]}"}

  step %{I should see my employee contributions for third period as "#{third_period[0]}"}
  step %{I should see my tax relief for third period as "#{third_period[1]}"}
  step %{I should see my employer contributions for third period as "#{third_period[2]}"}
  step %{I should see my total contributions for third period as "#{third_period[3]}"}
end
