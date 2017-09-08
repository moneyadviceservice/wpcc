Given(/^I am on the Your Details step$/) do
  your_details_page.load(language_code: language_code)
end

Given(/^I have valid details$/) do
  steps %{
    Given I am on the Your Details step
    When I fill in my details
    And I proceed to the next step
  }
end

Given(/^I enter my age as "([^"]*)"$/) do |age|
  your_details_page.age.set(age)
end

Given(/^I select my gender as "([^"]*)"$/) do |gender|
  your_details_page.genders.select(gender.capitalize)
end

Given(/^I enter my salary as "([^"]*)"$/) do |salary|
  your_details_page.salary.set(salary)
end

Given(/^I select my salary frequency as "([^"]*)"$/) do |salary_frequency|
  your_details_page.salary_frequencies.select(salary_frequency)
end

Given(/^I choose my contribution preference as "([^"]*)"$/) do |contribution_preference|
  your_details_page.send("#{contribution_preference.downcase}_contribution_button").set(true)
end

When(/^I choose to make minimum contributions$/) do
  your_details_page.minimum_contribution_button.set(true)
end

When(/^I choose to make( the)? full contribution(s)?$/) do |_,_|
  your_details_page.full_contribution_button.set(true)
end

Given(/^I am a "([^"]*)" year old "([^"]*)"$/) do |age, gender|
  step %{I enter my age as "#{age}"}
  step %{I select my gender as "#{gender}"}
end

When(/^I enter my details$/) do
  step %{I enter my age as "35"}
  step %{I select my gender as "#{I18n.translate('wpcc.details.options.gender.female')}"}
end

When(/^I enter my personal details$/) do
  step %{I enter my age as "35"}
  step %{I select my gender as "#{I18n.translate('wpcc.details.options.gender.female')}"}
  step %{I choose to make minimum contributions}
end

Given(/^my salary is "([^"]*)" "([^"]*)" with "([^"]*)" contribution$/) do |salary, salary_frequency, contribution|
  step %{I enter my salary as "#{salary}"}
  step %{I select my salary frequency as "#{salary_frequency}"}
  step %{I choose my contribution preference as "#{contribution}"}
end

When(/^I enter "([^"]*)" "([^"]*)" with contributions greater than the maximum for tax relief$/) do |salary, salary_frequency|
  step %{I enter my details}
  step %{my salary is "#{salary}" "#{salary_frequency}" with "Full" contribution}
  step %{I click the Next button}
  step %{my contribution is "60" percent}
end

When(/^I fill in my details$/) do
  step %{I enter my age as "35"}
  step %{I select my gender as "#{I18n.translate('wpcc.details.options.gender.female')}"}
  step %{I enter my salary as "35000"}
  step %{I select my salary frequency as "#{I18n.translate('wpcc.details.options.salary_frequency.year')}"}
  step %{I choose to make minimum contributions}
end

When(/^I fill in my details:$/) do |table|
  data = table.hashes.first
  step %{I enter my age as "#{data[:age]}"}
  step %{I select my gender as "#{data[:gender]}"}
  step %{I enter my salary as "#{data[:salary]}"}
  step %{I select my salary frequency as "#{data[:salary_frequency]}"}
  step %{I choose my contribution preference as "#{data[:contribution]}"}
end

When(/^my salary is "([^"]*)" "([^"]*)"$/) do |salary, salary_frequency|
  step %{I enter my salary as "#{salary}"}
  step %{I select my salary frequency as "#{salary_frequency}"}
end

When(/^I enter a "([^"]*)" below the minimum threshold$/) do |salary|
  step %{I enter my salary as "#{salary}"}
end

When(/^I enter a salary below the minimum threshold$/) do
  step %{I enter my salary as "5000"}
end

When(/^I select a valid "([^"]*)"$/) do |salary_frequency|
  step %{I select my salary frequency as "#{salary_frequency}"}
end

When(/^my salary per year is equal to or less than the upper earnings threshold of £45,000$/) do
  step %{I enter my salary as "35000"}
end

When(/^my salary per year is greater than the upper earnings threshold of £45,000$/) do
  step %{I enter my salary as "70000"}
end

When(/^I submit my details$/) do
  your_details_page.next_button.click
end

When(/^I click the Next button$/) do
  step 'I submit my details'
end

When(/^I proceed to the next step$/) do
  step 'I submit my details'
end

When(/^I press next and move to your contributions step$/) do
  step 'I submit my details'
end

Then(/^I should be able to proceed to the next page$/) do
  expect(page.current_url).to have_content('/your_contributions/new')
end

Then(/^I should NOT be able to progress to the next page$/) do
  expect(page.current_url).to have_content('/your_details')
  expect(page.current_url).not_to have_content('/your_contributions/new')
end

Then(/^I should see the "([^"]*)" for age$/) do |validation_message|
  expect(page).to have_content(validation_message)
end

Then(/^I should see "([^"]*)" summarised$/) do |my_details|
  expect(page).to have_content(my_details)
end

Then(/^the Your Contributions step should tell me my qualifying earnings$/) do
  expect(your_contributions_page.contributions_description).to have_content('£29,124')
end

Then(/^I should see that my qualifying earnings is the limit of "([^"]*)"$/) do |limit|
  expect(your_contributions_page.contributions_description).to have_content(limit)
end

Then(/^the Your Contributions step should tell me my qualifying earnings are my salary$/) do
  expect(your_contributions_page.contributions_description).to have_content("35,000")
end

Then(/^I should return to the Your Details step$/) do
  expect(your_details_page.form).to be_visible
end

Then(/^I should see my "([^"]*)", "([^"]*)", "([^"]*)", "([^"]*)" and "([^"]*)" in the form$/) do |age, gender, salary, selected_frequency, contribution |
  expect(your_details_page.age.value).to eq(age)
  expect(your_details_page.genders.value).to eq(gender)
  expect(your_details_page.salary.value).to eq(salary)
  expect(your_details_page.salary_frequencies.value).to eq(selected_frequency)
  expect(your_details_page.send("#{contribution.downcase}_contribution_button")).to be_truthy
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

Then(/^I should see that the minimum contribution option should be selected by default$/) do
  expect(your_details_page.minimum_contribution_button).to be_checked
end

Then(/^I should see that the full contribution option should( not| NOT)? be selected$/) do |should_not|
  if should_not
    expect(your_details_page.full_contribution_button).not_to be_checked
  else
    expect(your_details_page.full_contribution_button).to be_checked
  end
end

Then(/^I should see the salary below threshold "([^"]*)"$/) do |callout_message|
  expect(your_details_page.salary_below_threshold_callout).to have_content(callout_message)
end

Then(/^The form should be reset to its default values$/) do
  expect(your_details_page.age.value).to be_nil
  expect(your_details_page.genders.value).to eq("")
  expect(your_details_page.salary.value).to be_nil
  expect(your_details_page.salary_frequencies.value).to eq('year')
  expect(your_details_page.minimum_contribution_button).to be_truthy
end
