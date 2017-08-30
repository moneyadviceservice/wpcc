Feature: Reset the calculator
  In order that another user can not see my inputs,
  As a user working on a shared machine using the WPCC tool,
  I want to be able to clear my inputs of sensitive information (e.g. salary)

  Scenario:
    Given I have valid details
    And I have valid contributions
    When I click the reset the calculator button
    Then I should return to the Your Details step
    And The form should be reset to its default values
