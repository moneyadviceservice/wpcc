Feature: Your Details editing
  In order to change my details,
  As a user of the WPCC tool,
  I want to be able to return to edit my choices.

Background:
  Given I have valid details

Scenario: on Your Contributions page
  And I am on the Your Contributions step
  When I click to edit my details
  Then I should return to the Your Details step
  And I should see my current details in the form fields

Scenario: on Your Results page
  And I am on the Your Results step
  When I click to edit my details
  Then I should return to the Your Details step
  And I should see my current details in the form fields
