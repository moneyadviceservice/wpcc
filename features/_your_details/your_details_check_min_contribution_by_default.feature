Feature: Radio button for part salary is checked by default
  As a Workplace Pension Contribution Calculator user
  I need the selections to default to the scenario most likely to apply to me
  So that I can get my information without having to look things up

  Scenario Outline: Default contribution preference
    Given I am on the Your Details step
    Then I should see that the minimum contribution option should be selected by default
    And I should see that the full contribution option should not be selected
