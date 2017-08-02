Feature: Limit Tax Relief
  In order to get a clear picture of the impact on my take-home pay.
  As an employee contributing greater than £40,000 per year to my pension
  I want the results to reflect the fact that I will not get tax relief
  for any contribution over £40,000 per year.

  Background:
    Given I am on the Your Details step

    Scenario: Limit tax relief when above yearly figures
      Given I fill in my details:
        | age | gender | salary | salary_frequency | contribution |
        | 25  | male   | 80000  | per Year         | Full         |
      And I click the Next button
      And I fill in my contributions:
        | your_contribution | employer_contribution |
        | 60                | 1                     |
      When I move on to the results page
      Then I should see on the results page:
        | £48,000.00 | £48,000.00 | £48,000.00 |
        | £8,000.00  | £8,000.00  | £8,000.00  |
        | £800.00    | £1,600.00  | £2,400.00  |
        | £48,800.00 | £49,600.00 | £50,400.00 |

    Scenario: Limit tax relief when above weekly figures
      Given I fill in my details:
        | age | gender | salary | salary_frequency | contribution |
        | 25  | female | 1200   | per Week         | Full         |
      And I click the Next button
      And I fill in my contributions:
        | your_contribution | employer_contribution |
        | 65                | 1                     |
      When I move on to the results page
      Then I should see on the results page:
        | £780.00 | £780.00 | £780.00 |
        | £153.85 | £153.85 | £153.85 |
        | £12.00  | £24.00  | £36.00  |
        | £792.00 | £804.00 | £816.00 |

    Scenario: Limit tax relief when above monthly figures
      Given I fill in my details:
        | age | gender | salary | salary_frequency | contribution |
        | 23  | female | 4000   | per Month        | Full         |
      And I click the Next button
      And I fill in my contributions:
        | your_contribution | employer_contribution |
        | 90                | 1                     |
      When I move on to the results page
      Then I should see on the results page:
        | £3,600.00 | £3,600.00 | £3,600.00 |
        | £666.67   | £666.67   | £666.67   |
        | £40.00    | £80.00    | £120.00   |
        | £3,640.00 | £3,680.00 | £3,720.00  |

    Scenario: Limit tax relief when above per 4 weeks figures
      Given I fill in my details:
        | age | gender | salary | salary_frequency | contribution |
        | 23  | female | 5000   | per 4 weeks      | Full         |
      And I click the Next button
      And I fill in my contributions:
        | your_contribution | employer_contribution |
        | 90                | 1                     |
      When I move on to the results page
      Then I should see on the results page:
        | £4,500.00 | £4,500.00 | £4,500.00 |
        | £615.38   | £615.38   | £615.38   |
        | £50.00    | £100.00   | £150.00   |
        | £4,550.00 | £4,600.00 | £4,650.00 |
