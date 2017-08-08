Feature: Limit Tax Relief
  In order to get a clear picture of the impact on my take-home pay.
  As an employee contributing greater than £40,000 per year to my pension
  I want the results to reflect the fact that I will not get tax relief
  for any contribution over £40,000 per year.

  Background:
    Given I am on the Your Details step
    And I am a "25" year old "male"

    Scenario: Employee contributing more than £40,000 per year to pension
      Given my salary is "80000" "per Year" with "Full" contribution
      And I click the Next button
      And my contribution is "60" percent
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now        | April 2018 - March 2019 | Apr 2019 onwards |
        | Employee Contributions  | £4,000.00  | £4,000.00               | £4,000.00        |
        | Including tax relief of | £666.67    | £666.67                 | £666.67          |
        | Employer Contributions  | £66.67     | £133.33                 | £200.00          |
        | TOTAL Contributions     | £4,066.67  | £4,133.33               | £4,200.00        |

    Scenario: Employee contributing more than £769.23 per week to pension
      Given my salary is "1200" "per Week" with "Full" contribution
      And I click the Next button
      And my contribution is "65" percent
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now     | April 2018 - March 2019 | Apr 2019 onwards |
        | Employee Contributions  | £780.00 | £780.00                 | £780.00          |
        | Including tax relief of | £153.85 | £153.85                 | £153.85          |
        | Employer Contributions  | £12.00  | £24.00                  | £36.00           |
        | TOTAL Contributions     | £792.00 | £804.00                 | £816.00          |

    Scenario: Employee contributing more than £3,333.33 per month to pension
      Given my salary is "4000" "per Month" with "Full" contribution
      And I click the Next button
      And my contribution is "90" percent
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now       | April 2018 - March 2019 | Apr 2019 onwards |
        | Employee Contributions  | £3,600.00 | £3,600.00               | £3,600.00        |
        | Including tax relief of | £666.67   | £666.67                 | £666.67          |
        | Employer Contributions  | £40.00    | £80.00                  | £120.00          |
        | TOTAL Contributions     | £3,640.00 | £3,680.00               | £3,720.00        |

    Scenario: Employee contributing more than £3,076.92 per 4 weeks to pension
      Given my salary is "5000" "per 4 weeks" with "Full" contribution
      And I click the Next button
      And my contribution is "90" percent
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now       | April 2018 - March 2019 | Apr 2019 onwards |
        | Employee Contributions  | £4,500.00 | £4,500.00               | £4,500.00        |
        | Including tax relief of | £615.38   | £615.38                 | £615.38          |
        | Employer Contributions  | £50.00    | £100.00                 | £150.00          |
        | TOTAL Contributions     | £4,550.00 | £4,600.00               | £4,650.00        |