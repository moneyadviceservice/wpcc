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
      |                         | Now    | 
      | Employee Contributions  | £49.87 | 
      | Including tax relief of | £9.97  | 
      | Employer Contributions  | £29.92 | 
      | TOTAL Contributions     | £79.79 | 





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
      And I should see "<selected_frequency>" in the Recalculate Salary Frequency selector dropdown
    Examples:
      | age | gender | salary | salary_frequency | contribution_preference | employee_percent | employer_percent | employee_current_period | employer_current_period | tax_relief_current_period | total_current_period | selected_frequency | 
      | 25  | male   | 25000  | per year         | Minimum                 | 1                | 1                | £79.03                  | £47.42                  | £15.81                    | £126.45              | per month          |
      | 25  | male   | 18000  | per year         | Minimum                 | 1                | 1                | £49.97                  | £29.92                  | £9.97                     | £79.79               | per month          |
      | 25  | male   | 1500   | per month        | Minimum                 | 1                | 1                | £49.97                  | £29.92                  | £9.97                     | £79.79               | per month          |
      | 30  | female | 1000   | per month        | Full                    | 1                | 2                | £50.00                  | £1.00                   | £30.00                    | £80.00               | per month          |
      | 24  | male   | 380    | per week         | Minimum                 | 1                | 2                | £13.20                  | £7.92                   | £2.64                     | £21.12               | per week           |
      | 32  | female | 400    | per week         | Minimum                 | 5                | 3                | £14.20                  | £8.52                   | £2.84                     | £22.72               | per week           |
      | 24  | male   | 300    | per week         | Full                    | 5                | 4                | £15.00                  | £27.00                  | £3.00                     | £42.00               | per week           |
      | 18  | male   | 1900   | per 4 weeks      | Minimum                 | 2                | 1                | £71.80                  | £43.08                  | £14.36                    | £114.88              | per 4 weeks        |
