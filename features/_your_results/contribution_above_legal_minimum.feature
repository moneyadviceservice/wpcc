Feature:
  As a user who wants to contribute above the legal minimum
  I want my contributions to be reflected in the future contribution summaries
  So that I can see where my contributions will or won't rise.

  Background:
    Given I am on the Your Details step

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
      | 25  | male   | 20000  | per Year         | Minimum                 | 4                | 1                | £47.08                  | £9.42                     | £11.77                  | £58.85               | £47.08                 | £23.54                 | £9.42                    | £70.62              | £58.85                | £35.31                | £11.77                  | £94.16             |
      | 25  | female | 20000  | per Year         | Minimum                 | 1                | 5                | £11.77                  | £2.35                     | £58.85                  | £70.62               | £35.31                 | £58.85                 | £7.06                    | £94.16              | £58.85                | £58.85                | £11.77                  | £117.70            |
