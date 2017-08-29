Given(/^I am on the Your Results step$/) do
  your_results_page.load(language_code: language_code)
end

When(/^I visit Your results step directly$/) do
  step 'I am on the Your Results step'
end

When(/^I progress to the results page$/) do
  step 'I submit my details'
  step 'I am on the Your Results step'
end

When(/^I click to edit my contributions$/) do
  your_results_page.your_contributions_edit.click
end

When(/^I select "([^"]*)" to change the calculations$/) do |salary_frequency|
  your_results_page.salary_frequencies.select(salary_frequency)
end

When(/^I press recalculate$/) do
  your_results_page.recalculate_button.click
end

When(/^I click the reset the calculator button$/) do
  your_results_page.reset_calculator_link.click
end

Then(/^I should see "([^"]*)" in the Recalculate Salary Frequency selector dropdown$/) do |selected_frequency|
  expect(your_results_page).to have_select('salary_frequency', selected: selected_frequency)
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

Then(/^I should( not| NOT)? see tax relief "([^"]*)"$/) do |should_not, warning_message|
  if should_not
    expect(page).to_not have_content(warning_message)
  else
    expect(page).to have_content(warning_message)
  end
end

Then(/^I should( not)? see the manually_opt_in "([^"]*)"$/) do |should_not, message|
  if should_not
    expect(page).to_not have_content(message)
  else
    expect(page).to have_content(message)
  end
end

Then(/^my results should have "([^"]*)" "([^"]*)" and "([^"]*)"$/) do |your_heading, employer_heading, total_heading|
  headings = [your_heading, employer_heading, total_heading]
  expect(your_results_page.results_period_headings[0..2].map(&:text)).to eq(headings)
end

Then(/^I should see a link to the legal minimum contributions table$/) do
  expect(your_results_page).to have_legal_contributions_table_link
end

Then(/^I should see the percents information:$/) do |table|
  data = table.raw.flatten
  headings = ['', 'Now', 'April 2018 - March 2019', 'April 2019 onwards']
  expect(your_results_page.percent_table_headings.map{|cell| cell.text}).to eq(headings)
  expect(your_results_page.table_cells.map{|cell| cell.text}).to eq(data)
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

Then(/^I should see the values on the results page as:$/) do |table|
  data = table.transpose.raw
  current_period = data[1]
  second_period = data[2]
  third_period = data[3]

  step %{I should see my employee contributions for current period as "#{current_period[1]}"}
  step %{I should see my tax relief for current period as "#{current_period[2]}"}
  step %{I should see my employer contributions for current period as "#{current_period[3]}"}
  step %{I should see my total contributions for current period as "#{current_period[4]}"}

  step %{I should see my employee contributions for second period as "#{second_period[1]}"}
  step %{I should see my tax relief for second period as "#{second_period[2]}"}
  step %{I should see my employer contributions for second period as "#{second_period[3]}"}
  step %{I should see my total contributions for second period as "#{second_period[4]}"}

  step %{I should see my employee contributions for third period as "#{third_period[1]}"}
  step %{I should see my tax relief for third period as "#{third_period[2]}"}
  step %{I should see my employer contributions for third period as "#{third_period[3]}"}
  step %{I should see my total contributions for third period as "#{third_period[4]}"}
end

Then(/^I should see a contribution explanation "([^"]*)"$/) do |message|
  expect(your_results_page.description.first).to have_content(message)
end
