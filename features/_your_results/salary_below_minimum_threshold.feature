Feature: Employer contributions do not increase when user's salary is less than the minimum threshold
  In order to understand that there is no requirement for employer contributions to increase over time
  As an employee earning under the lower threshold per year
  I need to see employer contributions stay static

  Scenario Outline: For monthly, 4-weekly and weekly salary frequencies below the minimum threshold
    Given my "<salary>" "<salary_frequency>", regardless of "<part_or_full>" contribution, is below the minimum threshold
    And my employee contribution is "5"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    Then I should see that the "<employer_contribution>" is the same for each period

    Examples:
        | salary | salary_frequency | part_or_full | employer_percent | employer_contribution |
        | 416.67 | per month        | Full         | 3                | £12.48                |
        | 384.62 | per 4 weeks      | Full         | 3                | £11.52                |
        | 96.15  | per week         | Full         | 3                | £2.88                 |

  Scenario Outline: For annual salary frequency below the minimum threshold
    Given my "<salary>" "<salary_frequency>", regardless of "<part_or_full>" contribution, is below the minimum threshold
    And my employee contribution is "5"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    Then I should see that the employer_contributions is the same for each period at the "<monthly_value>"
    And I select "<salary_frequency>" to change the calculations
    And I press recalculate
    Then I should see that the employer_contributions is the same for each period at the "<yearly_value>"

    Examples:
        | salary | salary_frequency | part_or_full | employer_percent | monthly_value | yearly_value |
        | 5000   | per year         | Full         | 3                | £12.50        | £150.00      |

  Scenario Outline: For monthly, 4-weekly and weekly salary frequencies above the minimum threshold
    Given my "<salary>" "<salary_frequency>", regardless of "<part_or_full>" contribution, is above the minimum threshold
    And my employee contribution is "5"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    Then I should see employer_contributions for "<period_1>" increase as per the legal minimums

    Examples:
        | salary | salary_frequency | part_or_full | employer_percent | period_1 |
        | 1500   | per month        | Minimum      | 3                | £29.40   |
        | 1200   | per 4 weeks      | Minimum      | 3                | £21.60   |
        | 350    | per week         | Minimum      | 3                | £6.90    |

  Scenario Outline: For annual salary frequency above the minimum threshold
    Given my "<salary>" "<salary_frequency>", regardless of "<part_or_full>" contribution, is above the minimum threshold
    And my employee contribution is "5"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    And I select "<salary_frequency>" to change the calculations
    And I press recalculate
    Then I should see employer_contributions for "<period_1>" increase as per the legal minimums

    Examples:
        | salary  | salary_frequency | part_or_full | employer_percent | period_1 |
        | 11100   | per year         | Minimum      | 3                | £145.80  |
