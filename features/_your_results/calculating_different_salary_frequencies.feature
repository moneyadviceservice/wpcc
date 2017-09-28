Feature: displaying different salary frequencies
  In order to see my contributions in a format I understand
  As a user of the WPCC tool,
  I want to be able to choose the frequency with which my salary is calculated.

  Background:
    Given I am on the Your Details step

    Scenario: Salary Per Month calculation
      Given I fill in my details:
        | age | gender | salary | salary_frequency | contribution |
        | 25  | male   | 1500   | per Month        | Minimum      |
      And I click the Next button
      And I fill in my contributions:
        | your_contribution | employer_contribution |
        | 1                 | 1                     |
      When I move on to the results page
      Then I should see the values on the results page as:
      |                         | Now    | April 2018 - March 2019 | Apr 2019 onwards |
      | Employee Contributions  | £10.10 | £30.31                  | £50.52           |
      | Including tax relief of | £2.02  | £6.06                   | £10.10           |
      | Employer Contributions  | £10.10 | £20.21                  | £30.31           |
      | TOTAL Contributions     | £20.20 | £50.52                  | £80.83           |





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
      And I should see my employee contributions for third period as "<employee_third_period>"
      And I should see my employer contributions for third period as "<employer_third_period>"
      And I should see my tax relief for third period as "<tax_relief_third_period>"
      And I should see my total contributions for third period as "<total_third_period>"
      And I should see "<selected_frequency>" in the Recalculate Salary Frequency selector dropdown
    Examples:
      | age | gender | salary | salary_frequency | contribution_preference | employee_percent | employer_percent | employee_current_period | tax_relief_current_period | employer_current_period | total_current_period | employee_second_period | employer_second_period | tax_relief_second_period | total_second_period | employee_third_period | employer_third_period | tax_relief_third_period | total_third_period | selected_frequency |
      | 25  | male   | 25000  | per Year         | Minimum                 | 1                | 1                | £15.94                  | £3.19                     | £15.94                  | £31.88               | £47.81                 | £31.87                 | £9.56                    | £79.68              | £79.68                | £47.81                | £15.94                  | £127.49            | per Month          |
      | 25  | male   | 18000  | per Year         | Minimum                 | 1                | 1                | £10.10                  | £2.02                     | £10.10                  | £20.20               | £30.31                 | £20.21                 | £6.06                    | £50.52              | £50.52                | £30.31                | £10.10                  | £80.83             | per Month          |
      | 25  | male   | 1500   | per Month        | Minimum                 | 1                | 1                | £10.10                  | £2.02                     | £10.10                  | £20.20               | £30.31                 | £20.21                 | £6.06                    | £50.52              | £50.52                | £30.31                | £10.10                  | £80.83             | per Month          |
      | 30  | female | 1000   | per Month        | Full                    | 1                | 2                | £10.00                  | £2.00                     | £20.00                  | £30.00               | £30.00                 | £20.00                 | £6.00                    | £50.00              | £50.00                | £30.00                | £10.00                  | £80.00             | per Month          |
      | 24  | male   | 380    | per Week         | Minimum                 | 1                | 2                | £2.67                   | £0.53                     | £5.34                   | £8.01                | £8.01                  | £5.34                  | £1.60                    | £13.35              | £13.35                | £8.01                 | £2.67                   | £21.36             | per Week           |
      | 32  | female | 400    | per Week         | Minimum                 | 3                | 2                | £8.61                   | £1.72                     | £5.74                   | £14.35               |                        |                        |                          |                     | £14.35                | £8.61                 | £2.87                   | £22.96             | per Week           |
      | 24  | male   | 300    | per Week         | Full                    | 2                | 2                | £6.00                   | £1.20                     | £6.00                   | £12.00               | £9.00                  | £6.00                  | £1.80                    | £15.00              | £15.00                | £9.00                 | £3.00                   | £24.00             | per Week           |
      | 18  | male   | 1900   | per 4 weeks      | Minimum                 | 2                | 1                | £28.96                  | £5.79                     | £14.48                  | £43.44               | £43.44                 | £28.96                 | £8.69                    | £72.40              | £72.40                | £43.44                | £14.48                  | £115.84            | per 4 weeks        |
