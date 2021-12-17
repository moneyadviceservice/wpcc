Feature: displaying different salary frequencies
  In order to see my contributions in a format I understand
  As a user of the WPCC tool,
  I want to be able to choose the frequency with which my salary is calculated.

  Background:
    Given I am on the Your Details step

    Scenario: Salary Per Month calculation
      Given I fill in my details:
        | age | salary | salary_frequency | contribution |
        | 25  | 1500   | per month        | Minimum      |
      And I click the Next button
      And I fill in my contributions:
        | your_contribution | employer_contribution |
        | 5                 | 3                     |
      When I move on to the results page
      Then I should see the values on the results page as:
      |                         | Now    |
      | Employee Contributions  | £49.00 |
      | Including tax relief of | £9.80  |
      | Employer Contributions  | £29.40 |
      | TOTAL Contributions     | £78.40 |

    Scenario Outline:
      Given I enter my age as "<age>"
      And I enter my salary as "<salary>"
      And I select my salary frequency as "<salary_frequency>"
      And I choose my contribution preference as "<contribution_preference>"
      And I click the Next button
      And my employee contribution is "<employee_percent>"
      And my employer contribution is "<employer_percent>"
      When I move on to the results page
      Then I should see my employee contributions for current period as "<employee_current_period>"
      And I should see my tax relief for current period as "<tax_relief_current_period>"
      And I should see my employer contributions for current period as "<employer_current_period>"
      And I should see my total contributions for current period as "<total_current_period>"
      And I should see "<selected_frequency>" in the Recalculate Salary Frequency selector dropdown
    Examples:
      | age | salary | salary_frequency | contribution_preference | employee_percent | employer_percent | employee_current_period | employer_current_period | tax_relief_current_period | total_current_period | selected_frequency |
      | 25  | 25000  | per year         | Minimum                 | 5                | 3                | £78.17                  | £46.90                  | £15.63                    | £125.07              | per month          |
      | 25  | 18000  | per year         | Minimum                 | 5                | 3                | £49.00                  | £29.40                  | £9.80                     | £78.40               | per month          |
      | 25  | 1500   | per month        | Minimum                 | 5                | 3                | £49.00                  | £29.40                  | £9.80                     | £78.40               | per month          |
      | 30  | 1000   | per month        | Full                    | 5                | 3                | £50.00                  | £30.00                  | £10.00                    | £80.00               | per month          |
      | 24  | 380    | per week         | Minimum                 | 5                | 3                | £13.00                  | £7.80                   | £2.60                     | £20.80               | per week           |
      | 32  | 400    | per week         | Minimum                 | 5                | 3                | £14.00                  | £8.40                   | £2.80                     | £22.40               | per week           |
      | 24  | 300    | per week         | Full                    | 5                | 3                | £15.00                  | £9.00                   | £3.00                     | £24.00               | per week           |
      | 18  | 1900   | per 4 weeks      | Minimum                 | 5                | 3                | £71.00                  | £42.60                  | £14.20                    | £113.60              | per 4 weeks        |
