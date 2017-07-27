Feature:
  As a user
  I want to see my information that I filled on the step two
  So I can confirm my inputs are correct as I progress through the tool

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
    And I click to edit my contributions
    Then the employee percent input should be "<employee_percent>"
    And the employer percent input should be "<employer_percent>"

  Examples:
    | employee_percent | employer_percent |
    | 1                | 2                |
    | 2                | 3                |
    | 1                | 0                |