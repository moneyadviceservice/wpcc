Feature:
  As an employee contributing greater than £40,000 per year to my pension
  In order to get a clear picture of the impact on my take-home pay.
  I want the results to reflect the fact that I will not get tax relief
  for any contribution over £40,000 per year.

  Background:
    Given I am on the Your Details step of the tool

  Scenario: Annual Salary
    Given I fill my details:
      | age | gender | salary | salary_frequency | contribution |
      | 25  | male   | 80000  | per Year         | Full         |
    And I click the Next button
    And I fill my contributions:
      | your_contribution | employer_contribution |
      | 60                | 1                     |
    When I move on to the results page
    Then I should see on the results page:
      | £48,000.00 | £48,000.00 | £48,000.00 |
      | £8,000.00  | £8,000.00  | £8,000.00  |
      | £800.00    | £1,600.00  | £2,400.00  |
      | £48,800.00 | £49,600.00 | £50,400.00 |

  Scenario: Weekly Salary
    Given I fill my details:
      | age | gender | salary | salary_frequency | contribution |
      | 25  | female | 1200   | per Week         | Full         |
    And I click the Next button
    And I fill my contributions:
      | your_contribution | employer_contribution |
      | 65                | 1                     |
    When I move on to the results page
    Then I should see on the results page:
      | £780.00 | £780.00 | £780.00 |
      | £153.85 | £153.85 | £153.85 |
      | £12.00  | £24.00  | £36.00  |
      | £792.00 | £804.00 | £816.00 |

