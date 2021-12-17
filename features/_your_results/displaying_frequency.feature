Feature: Displaying frequency in the results table
  In order to fully understand what I will be paying and how often
  As a user trying to work out the impact of my contributions on my take-home pay
  I want to see the salary frequency being displayed clearly on my results

  Background:
    Given I am on the Your Details step

  Scenario Outline: When salary frequency is weekly, 4-weekly and monthly
    And I am a "<age>" year old
    And my salary is "<salary>" "<salary_frequency>" with "<contribution>" contribution
    And I click the Next button
    When I move on to the results page
    Then my results should have "<your_heading>" "<employer_heading>" and "<total_heading>"

    Examples:
      | age | salary | salary_frequency | contribution | your_heading               | employer_heading                 | total_heading                |
      | 35  | 200    | per week         | Minimum      | Your weekly contribution   | Employer's weekly contribution   | Total weekly contributions   |
      | 55  | 1200   | per 4 weeks      | Full         | Your 4-weekly contribution | Employer's 4-weekly contribution | Total 4-weekly contributions |
      | 25  | 1500   | per month        | Minimum      | Your monthly contribution  | Employer's monthly contribution  | Total monthly contributions  |


    @welsh
    Examples:
      | age | salary | salary_frequency | contribution | your_heading                 | employer_heading                   | total_heading                      |
      | 45  | 200    | y wythnos        | Minimum      | Eich cyfraniad wythnosol     | Cyfraniad wythnosol y cyflogwr     | Cyfanswm y cyfraniad wythnosol     |
      | 53  | 1200   | fesul 4 wythnos  | Full         | Eich cyfraniad bob 4 wythnos | Cyfraniad y cyflogwr bob 4 wythnos | Cyfanswm y cyfraniad bob 4 wythnos |
      | 28  | 1500   | y mis            | Minimum      | Eich cyfraniad misol         | Cyfraniad misol y cyflogwr         | Cyfanswm y cyfraniad misol         |

  Scenario Outline: When salary frequency is yearly
    And I am a "<age>" year old
    Given my salary is "<salary>" "<salary_frequency>" with "<contribution>" contribution
    And I click the Next button
    When I move on to the results page
    And I move on to the results page
    When I select "<salary_frequency>" to change the calculations
    And I press recalculate
    Then my results should have "<your_heading>" "<employer_heading>" and "<total_heading>"

    Examples:
      | age | salary | salary_frequency | contribution | your_heading             | employer_heading               | total_heading                |
      | 37  | 25000  | per year         | Full         | Your annual contribution | Employer's annual contribution | Total annual contributions   |

    @welsh
    Examples:
      | age | salary | salary_frequency | contribution | your_heading             | employer_heading               | total_heading                  |
      | 32  | 25000  | y flwyddyn       | Minimum      | Eich cyfraniad blynyddol | Cyfraniad blynyddol y cyflogwr | Cyfanswm y cyfraniad blynyddol |
