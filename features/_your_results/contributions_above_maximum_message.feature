Feature: Limit Tax Relief
  In order to get a clear picture of the impact on my take-home pay.
  As an employee contributing greater than £40,000 per year to my pension
  I want the results to reflect the fact that I will not get tax relief
  for any contribution over £40,000 per year.

  Scenario Outline: Employee contributing more than the equivalent of £40,000 per year to pension
    Given I am on the Your Details step
    When I enter "<salary>" "<salary_frequency>" with contributions greater than the maximum for tax relief
    And I move on to the results page
    Then I should see the contribution above maximum "<message>"

    Examples:
      | salary  | salary_frequency | message |
      | 80000   | per year         | Tax relief is only applied to contributions of up to £40,000 per year or 100% of your earnings, whichever is lower. |
      | 40000   | per month        | Tax relief is only applied to contributions of up to £40,000 per year or 100% of your earnings, whichever is lower. |
      | 45000   | per 4 weeks      | Tax relief is only applied to contributions of up to £40,000 per year or 100% of your earnings, whichever is lower. |
      | 12000   | per week         | Tax relief is only applied to contributions of up to £40,000 per year or 100% of your earnings, whichever is lower. |

    @welsh
    Examples:
      | salary  | salary_frequency | message |
      | 80000   | y flwyddyn       | Rhoddir gostyngiad treth ar gyfraniadau hyd at £40,000 y flwyddyn yn unig, neu 100% o’ch enillion, pa bynnag un sydd leiaf. |
      | 40000   | y mis            | Rhoddir gostyngiad treth ar gyfraniadau hyd at £40,000 y flwyddyn yn unig, neu 100% o’ch enillion, pa bynnag un sydd leiaf. |
      | 45000   | fesul 4 wythnos  | Rhoddir gostyngiad treth ar gyfraniadau hyd at £40,000 y flwyddyn yn unig, neu 100% o’ch enillion, pa bynnag un sydd leiaf. |
      | 12000   | y wythnos        | Rhoddir gostyngiad treth ar gyfraniadau hyd at £40,000 y flwyddyn yn unig, neu 100% o’ch enillion, pa bynnag un sydd leiaf. |

