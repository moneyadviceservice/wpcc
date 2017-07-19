Feature:
  As an employee, I want to be able to see my results in a frequency different to how I input my salary because I want to understand how the contributions will impact my monthly or weekly take-home pay.

  Background:
    Given I am on the YourDetailsPage

  Scenario Outline:
    Given I enter my age as "<age>"
    And   I select my gender as "<gender>"
    And   I enter my salary as "<salary>"
    And   I select my salary frequency as "<salary_frequency>"
    And   I select the minimum contribution
    And   I press next and move to your contributions step
    And   I press next and move to your result step
    When  I select "<salary_frequency>" to change the calculations
    And   I press recalculate
    Then  I should see my employee contributions for current period as "<employee_current_period>"
    And   I should see my tax relief for current period as "<tax_relief_current_period>"
    And   I should see my employer contributions for current period as "<employer_current_period>"
    And   I should see my total contributions for current period as "<total_current_period>"
    And   I should see my employee contributions for second period as "<employee_second_period>"
    And   I should see my employer contributions for second period as "<employer_second_period>"
    And   I should see my tax relief for second period as "<tax_relief_second_period>"
    And   I should see my total contributions for second period as "<total_second_period>"
    And   I should see my employee contributions for third period as "<employee_third_period>"
    And   I should see my employer contributions for third period as "<employer_third_period>"
    And   I should see my tax relief for third period as "<tax_relief_third_period>"
    And   I should see my total contributions for third period as "<total_third_period>"


  Examples:
    | age | gender | salary   | salary_frequency | employee_current_period | employee_second_period | employee_third_period | tax_relief_current_period | tax_relief_second_period | tax_relief_third_period | employer_current_period | employer_second_period | employer_third_period | total_current_period | total_second_period | total_third_period |
    | 25  | male   | 25000    | per Year         | £191.24                 | £573.72                | £956.20               | £38.25                    | £114.74                  | £191.24                 | £191.24                 | £382.48                | £573.72               | £382.48              | £956.20             | £1,529.92          |
    | 25  | male   | 2083     | per Month        | £15.93                  | £47.80                 | £79.67                | £3.19                     | £9.56                    | £15.93                  | £15.93                  | £31.87                 | £47.80                | £31.86               | £79.67              | £127.47            |
    | 25  | male   | 1923     | per 4 weeks      | £14.71                  | £44.13                 | £73.55                | £2.94                     | £8.83                    | £14.71                  | £14.71                  | £29.42                 | £44.13                | £29.42               | £73.55              | £117.68            |
    | 25  | male   | 480      | per Week         | £3.67                   | £11.01                 | £18.35                | £0.73                     | £2.20                    | £3.67                   | £3.67                   | £7.34                  | £11.01                | £7.34                | £18.35              | £29.36             |
                                    