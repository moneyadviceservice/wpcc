Feature: Contributions - displayed in future steps
  In order to confirm my inputs are correct as I progress through the tool,
  As a user of the WPCC tool,
  I want to see the contributions that I filled in on the step two.

  Background:
    Given I am on the YourDetailsPage
    When I enter my age as 35
    And I enter my gender as female
    And my salary per year is greater than the upper earnings threshold of £45,000
    And I select per Year salary frequency
    And I select the minimum contribution
    And I press next

  Scenario Outline:
    Given my employee contribution is "<employee_percent>"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    Then I should see my contributions as "(You: <employee_percent>%, Your employer: <employer_percent>%)"
  Examples:
      | employee_percent | employer_percent |
      | 1                | 1                |
      | 2                | 3                |
      | 3                | 2                |
      | 2                | 4                |
