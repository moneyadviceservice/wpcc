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
      And I should see my tax relief for current period as "<tax_relied_current_period>"
      And I should see my employer contributions for current period as "<employer_current_period>"
      And I should see my total contributions for current period as "<total_current_period>"
    Examples:
      | age | gender | salary | salary_frequency | contribution_preference | employee_percent | employer_percent | employee_current_period | tax_relied_current_period | employer_current_period | total_current_period |
      | 24  | male   | 380    | per Week         | Minimum                 | 1                | 2                | £2.67                   | £0.53                     | £5.34                   | £8.01                |
      | 32  | female | 400    | per Week         | Full                    | 3                | 2                | £8.61                   | £1.72                     | £5.74                   | £14.35               |
