Feature: Employer contributions do not increase when user's salary is less than the minimum threshold
  In order to understand that there is no requirement for employer contributions to increase over time
  As an employee earning under £5876 per year
  I need to see employer contributions stay static

  Scenario Outline: For monthly, 4-weekly and weekly salary frequencies
    Given my "<salary>" "<salary_frequency>" is below the minimum threshold
    And my employee contribution is "1"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    Then I should see that the "<employer_contribution>" is the same for each period

    Examples:
        | salary | salary_frequency  | employer_percent | employer_contribution |
        | 416.67 | per Month         | 0                | £0.00                 |
        | 416.67 | per Month         | 1                | £4.16                 |
        | 384.62 | per 4 weeks       | 0                | £0.00                 |
        | 384.62 | per 4 weeks       | 1                | £3.84                 |
        | 96.15  | per Week          | 0                | £0.00                 |
        | 96.15  | per Week          | 1                | £0.96                 |

  Scenario Outline: For annual salary frequency
    Given my "<salary>" "<salary_frequency>" is below the minimum threshold
    And my employee contribution is "1"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    And I select "<salary_frequency>" to change the calculations
    And I press recalculate
    Then I should see that the "<employer_contribution>" is the same for each period

    Examples:
        | salary | salary_frequency | employer_percent | employer_contribution |
        | 5000   | per Year         | 0                | £0.00                 |
        | 5000   | per Year         | 1                | £50.00                |
