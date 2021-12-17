Feature: Validating contribution percentages
  In order to gain a better understanding of how my workplace pension is being calculated,
  As a user of the WPCC tool,
  I want to see relevant information about the contributions my employer and I can make.

Background:
  Given I am on the Your Details step
  
Scenario Outline: Adds up to 8% or more for a 30 year old
  And I am a "30" year old
  And I enter my salary as "45000"
  And I choose my contribution preference as "<contribution_preference>"
  And I click the Next button
  And my employee contribution is "<employee_percent>"
  And my employer contribution is "<employer_percent>"
  And I move on to the results page
  Then I should see my employee contributions for current period as "<employee_current_period>"
  And I should see my employer contributions for current period as "<employer_current_period>"
  Examples:
    | contribution_preference | employee_percent | employer_percent | employee_current_period | employer_current_period |
    | Full                    | 5.0              | 3.0              | £187.50                 | £112.50                 |
    | Full                    | 4.0              | 4.0              | £150.00                 | £150.00                 |
    | Full                    | 2.0              | 6.0              | £75.00                  | £225.00                 |
    | Minimum                 | 2.0              | 6.0              | £64.60                  | £193.80                 |
    | Minimum                 | 7.0              | 3.0              | £226.10                 | £96.90                  |
    | Minimum                 | 0.0              | 8.0              | £0.00                   | £258.40                 |

Scenario Outline: Adds up to 8% or more for a 39 year old
  And I am a "28" year old
  And I enter my salary as "28569"
  And I choose my contribution preference as "<contribution_preference>"
  And I click the Next button
  And my employee contribution is "<employee_percent>"
  And my employer contribution is "<employer_percent>"
  And I move on to the results page
  Then I should see my employee contributions for current period as "<employee_current_period>"
  And I should see my employer contributions for current period as "<employer_current_period>"
  Examples:
    | contribution_preference | employee_percent | employer_percent | employee_current_period | employer_current_period |
    | Full                    | 5.5              | 6.5              | £130.94                 | £154.75                 |
    | Minimum                 | 5.5              | 6.5              | £102.34                 | £120.95                 |

Scenario Outline: Adds up to 8% or more for a 64 year old
  And I am a "64" year old
  And my salary is "4100" "per month" with "<contribution_preference>" contribution
  And I click the Next button
  And my employee contribution is "<employee_percent>"
  And my employer contribution is "<employer_percent>"
  And I move on to the results page
  Then I should see my employee contributions for current period as "<employee_current_period>"
  And I should see my employer contributions for current period as "<employer_current_period>"
  Examples:
    | contribution_preference | employee_percent | employer_percent | employee_current_period | employer_current_period |
    | Full                    | 3.0              | 7.0              | £123.00                 | £287.00                 |
    | Minimum                 | 3.0              | 7.0              | £107.40                 | £250.60                 |


Scenario Outline: Adds up to less than 8%
  And I fill in my details
  And I enter my salary as "35000"
  And I choose my contribution preference as "<contribution_preference>"
  And I click the Next button
  And my employee contribution is "<employee_percent>"
  And my employer contribution is "<employer_percent>"
  And I click the Next button
  Then I stay on the Your Contributions step
  And I see an error message "Total contribution must be at least 8%"
  Examples:
    | contribution_preference | employee_percent | employer_percent |
    | Full                    | 0.0              | 3.0              |
    | Full                    | 1.0              | 3.0              |
    | Full                    | 2.5              | 3.0              |
    | Full                    | 2.5              | 4.0              |
    | Minimum                 | 1.5              | 3.0              |
    | Minimum                 | 3.0              | 3.0              |
    | Minimum                 | 2.5              | 4.0              |
    | Minimum                 | 2.0              | 5.0              |
