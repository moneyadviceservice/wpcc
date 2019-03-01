Feature: Limit Tax Relief
  In order to get a clear picture of the impact on my take-home pay.
  As an employee contributing greater than £40,000 per year to my pension
  I want the results to reflect the fact that I will not get tax relief
  for any contribution over £40,000 per year.

  Background:
    Given I am on the Your Details step
    And I am a "25" year old "male"

    Scenario: Employee contributing more than £40,000 per year to pension
      Given my salary is "80000" "per year" with "Full" contribution
      And I click the Next button
      And my contribution is "60" percent
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now              |
        | Employee Contributions  | £4,000.00        |
        | Including tax relief of | £666.67          |
        | Employer Contributions  | £200.00          |
        | TOTAL Contributions     | £4,200.00        |

    Scenario: Employee contributing more than £769.23 per week to pension
      Given my salary is "1200" "per week" with "Full" contribution
      And I click the Next button
      And my contribution is "65" percent
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now              |
        | Employee Contributions  | £780.00          |
        | Including tax relief of | £153.85          |
        | Employer Contributions  | £36.00           |
        | TOTAL Contributions     | £816.00          |

    Scenario: Employee contributing more than £3,333.33 per month to pension
      Given my salary is "4000" "per month" with "Full" contribution
      And I click the Next button
      And my contribution is "90" percent
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now              |
        | Employee Contributions  | £3,600.00        |
        | Including tax relief of | £666.67          |
        | Employer Contributions  | £120.00          |
        | TOTAL Contributions     | £3,720.00        |

    Scenario: Employee contributing more than £3,076.92 per 4 weeks to pension
      Given my salary is "5000" "per 4 weeks" with "Full" contribution
      And I click the Next button
      And my contribution is "90" percent
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now              |
        | Employee Contributions  | £4,500.00        |
        | Including tax relief of | £615.38          |
        | Employer Contributions  | £150.00          |
        | TOTAL Contributions     | £4,650.00        |
