Then(/^I should( not| NOT)? see a tooltip next to the qualifying earnings text$/) do |should_not|
  if should_not
    expect(page).not_to have_css('button.t-qualifying-earnings')
  else
    expect(page).to have_css('button.t-qualifying-earnings')
  end
end
