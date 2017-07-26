Given(/^that I am on the WPCC homepage in my own "([^"]*)"$/) do |language|
  locale = language_to_locale(language)

  your_details_page.load(locale: locale)
end

When(/^I enter my personal details$/) do
  your_details_page.age.set(35)
  your_details_page.genders.select(
    I18n.translate('wpcc.details.options.gender.female')
  )
  your_details_page.salary_frequencies.select(
    I18n.translate('wpcc.details.options.salary_frequency.year')
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
