Feature: Your Details displaying
  In order to confirm my inputs are correct as I progress through the tool,
  As a user of the WPCC tool,
  I want to see my details that I filled in on step one.

Scenario: Display input details on later steps
  Given I am on the Your Details step
  When I fill in my details
  And I proceed to the next step
  Then I should see my details summarised
