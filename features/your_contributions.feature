Feature:
  As a user of the WPCC tool,
  In order to change my details,
  I want to be able to go back to the first step.

Scenario:
  Given I am on the WPCC homepage
  And   I complete the first step and move on to second step
  When  I click edit on the first step section
  Then  I should return to the first step
  And   I should see my details in the form fields
