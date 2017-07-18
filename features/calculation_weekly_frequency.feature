Feature:
  As a enrolee into a Workplace Pension,
  I would like to calculate pension contribution on my weekly salary.

  Background:
    Given I am on the YourDetailsPage

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
    Examples:
      | age | gender | salary | salary_frequency | contribution_preference | employee_percent | employer_percent | employee_current_period | tax_relief_current_period | employer_current_period | total_current_period | employee_second_period | employer_second_period | tax_relief_second_period | total_second_period | employee_third_period | employer_third_period | tax_relief_third_period | total_third_period |
      | 24  | male   | 380    | per Week         | Minimum                 | 1                | 2                | £2.67                   | £0.53                     | £5.34                   | £8.01                | £8.01                  | £5.34                  | £1.60                    | £13.35              | £13.35                | £10.68                | £2.67                   | £21.36             |
      | 32  | female | 400    | per Week         | Minimum                 | 3                | 2                | £8.61                   | £1.72                     | £5.74                   | £14.35               |                        |                        |                          |                     | £14.35                | £8.61                 | £2.87                   | £22.96             |
      | 24  | male   | 300    | per Week         | Full                    | 2                | 2                | £6.00                   | £1.20                     | £6.00                   | £12.00               | £9.00                  | £6.00                  | £1.80                    | £15.00              | £15.00                | £9.00                 | £3.50                   | £24.00             |
