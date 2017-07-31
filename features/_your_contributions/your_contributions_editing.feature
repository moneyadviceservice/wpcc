Feature: Your contributions editing
  In order to change my contributions,
  As a user of the WPCC tool,
  I want to be able to return to edit my choices.

  Background:
    Given I have valid details
    And I have valid contributions

  Scenario:
    And I am on the Your Results step
    When I click to edit my contributions
    Then I should return to the Your Contributions step
    And I should see my current contributions in the form fields
