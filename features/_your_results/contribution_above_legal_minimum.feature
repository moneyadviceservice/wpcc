Feature:
  As a user who wants to contribute above the legal minimum
  I want my contributions to be reflected in the future contribution summaries
  So that I can see where my contributions will or won't rise.

  Background:
    Given I am on the Your Details step
    And I fill in my details:
      | age | gender | salary | salary_frequency | contribution |
      | 25  | male   | 20000  | per year         | Minimum      |
    And I proceed to the next step

    Scenario: When employee contribution is above default
      And my employee contribution is "4"
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now    |
        | Employee Contributions  | £57.77 |
        | Including tax relief of | £11.55 |
        | Employer Contributions  | £34.66 |
        | TOTAL Contributions     | £92.43 |

    Scenario: When employer contribution is above default
      And my employer contribution is "5"
      When I move on to the results page
      Then I should see the values on the results page as:
        |                          | Now     |
        | Employee Contributions   | £57.77  |
        | Including tax relief of  | £11.55  |
        | Employer Contributions   | £57.77  |
        | TOTAL Contributions      | £115.54 |
