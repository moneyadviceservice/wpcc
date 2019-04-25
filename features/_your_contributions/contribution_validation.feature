Feature: Validating contribution percentages
  In order to gain a better understanding of how my workplace pension is being calculated,
  As a user of the WPCC tool,
  I want to see relevant information about the contributions my employer and I can make.

Background:
  Given I am on the Your Details step
  When I fill in my details
  And I enter my salary as "45000"

Scenario Outline: Adds up to 8% or more
  And I choose my contribution preference as "<contribution_preference>"
  And I click the Next button
  And my employee contribution is "<employee_percent>"
  And my employer contribution is "<employer_percent>"
  And I move on to the results page
  And I should see my employer contributions for current period as "<employee_current_period>"
  And I should see my total contributions for current period as "<employer_current_period>"
  Examples:
    | contribution_preference | employee_percent | employer_percent | employee_current_period | employer_current_period |
    | Full                    | 5.0              | 3.0              | £112.50                 | £300.00                 |
    | Full                    | 4.0              | 4.0              | £150.00                 | £337.50                 |
    | Full                    | 2.0              | 6.0              | £225.00                 | £412.50                 |
    | Minimum                 | 2.0              | 6.0              | £194.32                 | £356.25                 |
    | Minimum                 | 7.0              | 3.0              | £97.16                  | £323.87                 |
    | Minimum                 | 0.0              | 8.0              | £259.09                 | £421.02                 |

Scenario Outline: Adds up to less than 8%
  And I choose my contribution preference as "<contribution_preference>"
  And I click the Next button
  And my employee contribution is "<employee_percent>"
  And my employer contribution is "<employer_percent>"
  And I click the Next button
  Then I stay on the Your Contributions step
  And I see an error message
  Examples:
    | contribution_preference | employee_percent | employer_percent |
    | Full                    | 7.0              | 0.0              |
    | Full                    | 3.0              | 4.0              |
    | Full                    | 0.5              | 7.0              |
    | Minimum                 | 1.0              | 6.0              |
    | Minimum                 | 2.0              | 3.0              |
    | Minimum                 | 5.0              | 2.0              |

Scenario Outline: Employer contribution is less than 3%
  And I choose my contribution preference as "<contribution_preference>"
  And I click the Next button
  And my employee contribution is "<employee_percent>"
  And my employer contribution is "<employer_percent>"
  And I click the Next button
  Then I stay on the Your Contributions step
  And I see an error message
  Examples:
    | contribution_preference | employee_percent | employer_percent |
    | Full                    | 8.0              | 0.0              |
    | Full                    | 7.0              | 1.0              |
    | Full                    | 6.5              | 2.0              |
    | Minimum                 | 8.0              | 0.0              |
    | Minimum                 | 7.0              | 1.0              |
    | Minimum                 | 6.0              | 2.0              |
