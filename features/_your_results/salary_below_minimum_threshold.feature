Feature: Employer contributions do not increase when user's salary is less than the minimum threshold
  In order to understand that there is no requirement for employer contributions to increase over time
  As an employee earning under £5876 per year
  I need to see employer contributions stay static

  Scenario Outline: For monthly, 4-weekly and weekly salary frequencies below the minimum threshold
    Given my "<salary>" "<salary_frequency>", regardless of "<part_or_full>" contribution, is below the minimum threshold
    And my employee contribution is "1"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    Then I should see that the "<employer_contribution>" is the same for each period

    Examples:
        | salary | salary_frequency | part_or_full | employer_percent | employer_contribution |
        | 416.67 | per month        | Full         | 0                | £0.00                 |
        | 416.67 | per month        | Full         | 1                | £4.16                 |
        | 384.62 | per 4 weeks      | Full         | 0                | £0.00                 |
        | 384.62 | per 4 weeks      | Full         | 1                | £3.84                 |
        | 96.15  | per week         | Full         | 0                | £0.00                 |
        | 96.15  | per week         | Full         | 1                | £0.96                 |

  Scenario Outline: For annual salary frequency below the minimum threshold
    Given my "<salary>" "<salary_frequency>", regardless of "<part_or_full>" contribution, is below the minimum threshold
    And my employee contribution is "1"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    Then I should see that the employer_contributions is the same for each period at the "<monthly_value>"
    And I select "<salary_frequency>" to change the calculations
    And I press recalculate
    Then I should see that the employer_contributions is the same for each period at the "<yearly_value>"

    Examples:
        | salary | salary_frequency | part_or_full | employer_percent | monthly_value | yearly_value |
        | 5000   | per year         | Full         | 0                | £0.00         | £0.00        |
        | 5000   | per year         | Full         | 1                | £4.17         | £50.00       |

  Scenario Outline: For monthly, 4-weekly and weekly salary frequencies above the minimum threshold
    Given my "<salary>" "<salary_frequency>", regardless of "<part_or_full>" contribution, is above the minimum threshold
    And my employee contribution is "1"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    Then I should see employer_contributions for "<period_1>", "<period_2>" and "<period_3>" increase as per the legal minimums

    Examples:
        | salary | salary_frequency | part_or_full | employer_percent | period_1   | period_2 | period_3 |
        | 1500   | per month        | Minimum      | 0                | £0.00      | £20.21   | £30.31   |
        | 1500   | per month        | Minimum      | 1                | £10.10     | £20.21   | £30.31   |
        | 1200   | per 4 weeks      | Minimum      | 0                | £0.00      | £14.96   | £22.44   |
        | 1200   | per 4 weeks      | Minimum      | 1                | £7.48      | £14.96   | £22.44   |
        | 350    | per week         | Minimum      | 0                | £0.00      | £4.74    | £7.11    |
        | 350    | per week         | Minimum      | 1                | £2.37      | £4.74    | £7.11    |

  Scenario Outline: For annual salary frequency above the minimum threshold
    Given my "<salary>" "<salary_frequency>", regardless of "<part_or_full>" contribution, is above the minimum threshold
    And my employee contribution is "1"
    And my employer contribution is "<employer_percent>"
    When I move on to the results page
    And I select "<salary_frequency>" to change the calculations
    And I press recalculate
    Then I should see employer_contributions for "<period_1>", "<period_2>" and "<period_3>" increase as per the legal minimums

    Examples:
        | salary  | salary_frequency | part_or_full | employer_percent | period_1   | period_2 | period_3 |
        | 11100   | per year         | Minimum      | 0                | £0.00      | £104.48  | £156.72  |
        | 11100   | per year         | Minimum      | 1                | £52.24     | £104.48  | £156.72  |
