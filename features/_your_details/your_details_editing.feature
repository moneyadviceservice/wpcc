Feature: Details - editing
  In order to change my details,
  As a user of the WPCC tool,
  I want to be able to return to edit my choices.

Background:
  Given I am on the WPCC homepage

Scenario: on Your Contributions page
  And   I complete the your details form and move to your contributions page
  When  I click edit on the your details summary
  Then  I should return to the your details page
  And   I should see my details in the form fields

Scenario: on Your Results page
  And   I complete the your details form and move to your contributions page
  And   I complete the your contributions form
  And   I move to your results page
  When  I click edit on the your details summary
  Then  I should return to the your details page
  And   I should see my details in the form fields
