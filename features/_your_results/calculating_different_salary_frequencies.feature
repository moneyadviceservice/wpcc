Feature: displaying different salary frequencies
  In order to see my contributions in a format I understand
  As a user of the WPCC tool,
  I want to be able to choose the frequency with which my salary is calculated.

  Background:
    Given I am on the Your Details step

    Scenario: Salary Per Month calculation
      Given I fill in my details:
        | age | gender | salary | salary_frequency | contribution |
        | 25  | male   | 1500   | per month        | Minimum      |
      And I click the Next button
      And I fill in my contributions:
        | your_contribution | employer_contribution |
        | 1                 | 1                     |
      When I move on to the results page
      Then I should see the values on the results page as:
      |                         | Now    | Apr 2019 onwards |
      | Employee Contributions  | £29.92 | £49.87           |
      | Including tax relief of | £5.98  | £9.97            |
      | Employer Contributions  | £19.95 | £29.92           |
      | TOTAL Contributions     | £49.87 | £79.79           |





    Scenario Outline:
      Given I enter my age as "<age>"
      And I select my gender as "<gender>"
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
      And I should see my employee contributions for second period as "<employee_second_period>"
      And I should see my employer contributions for second period as "<employer_second_period>"
      And I should see my tax relief for second period as "<tax_relief_second_period>"
      And I should see my total contributions for second period as "<total_second_period>"
      And I should see "<selected_frequency>" in the Recalculate Salary Frequency selector dropdown
    Examples:
      | age | gender | salary | salary_frequency | contribution_preference | employee_percent | employer_percent | employee_current_period | employer_current_period | tax_relief_current_period | total_current_period | employee_second_period | employer_second_period | tax_relief_second_period | total_second_period | selected_frequency |
      | 25  | male   | 25000  | per year         | Minimum                 | 1                | 1                | £47.42                  | £31.61                  | £9.48                     | £79.03               | £79.03                 | £47.42                 | £15.81                   | £126.45             | per month          |
      | 25  | male   | 18000  | per year         | Minimum                 | 1                | 1                | £29.92                  | £19.95                  | £5.98                     | £49.87               | £49.87                 | £29.92                 | £9.97                    | £79.79              | per month          |
      | 25  | male   | 1500   | per month        | Minimum                 | 1                | 1                | £29.92                  | £19.95                  | £5.98                     | £49.87               | £49.87                 | £29.92                 | £9.97                    | £79.79              | per month          |
      | 30  | female | 1000   | per month        | Full                    | 1                | 2                | £30.00                  | £20.00                  | £6.00                     | £50.00               | £50.00                 | £30.00                 | £10.00                   | £80.00              | per month          |
      | 24  | male   | 380    | per week         | Minimum                 | 1                | 2                | £7.92                   | £5.28                   | £1.58                     | £13.20               | £13.20                 | £7.92                  | £2.64                    | £21.12              | per week           |
      | 32  | female | 400    | per week         | Minimum                 | 3                | 2                | £8.52                   | £5.68                   | £1.70                     | £14.20               | £14.20                 | £8.52                  | £2.84                    | £22.72              | per week           |
      | 24  | male   | 300    | per week         | Full                    | 2                | 2                | £9.00                   | £6.00                   | £1.80                     | £15.00               | £15.00                 | £9.00                  | £3.00                    | £24.00              | per week           |
      | 18  | male   | 1900   | per 4 weeks      | Minimum                 | 2                | 1                | £43.08                  | £28.72                  | £8.62                     | £71.80               | £71.80                 | £43.08                 | £14.36                   | £114.88             | per 4 weeks        |
