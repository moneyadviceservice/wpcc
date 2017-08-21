Feature: Your Contributions displaying
  In order to confirm my inputs are correct as I progress through the tool,
  As a user of the WPCC tool,
  I want to see the contributions that I filled in on step two.

  Scenario:
    Given I have valid details
    And I am on the Your Contributions step
    When I fill in my employer and employee contributions
    And I proceed to the next step
    Then I should see my contributions summarised
