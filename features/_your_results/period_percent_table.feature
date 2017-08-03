Feature: Period Percents Information Table
  In order to understand the legal minimum contributions requirements
  As a user who has just completed the WPCC tool
  I want to the minimum contribution percentages

  Scenario Outline:
    Given I am on the Your Details step
    And I have valid details
    And my employee contribution is "<my_contribution>"
    And my employer contribution is "<employer_contribution>"
    When I move on to the results page
    Then I should see a link to the legal minimum contributions table
    And I should see the percents information:
        | You           | 1% | 3% | 5% |
        | Your employer | 1% | 2% | 3% |

    Examples:
        | my_contribution | employer_contribution |
        | 1               | 1                     |
        | 5               | 5                     |
        | 1               | 0                     |
        | 2               | 1                     |
