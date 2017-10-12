Feature:
  As a user who wants to contribute above the legal minimum
  I want my contributions to be reflected in the future contribution summaries
  So that I can see where my contributions will or won't rise.

  Background:
    Given I am on the Your Details step
    And I fill in my details:
      | age | gender | salary | salary_frequency | contribution |
      | 25  | male   | 20000   | per year        | Minimum      |
    And I proceed to the next step

    Scenario: When employee contribution is above default
      And my employee contribution is "4"
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now    | April 2018 - March 2019 | Apr 2019 onwards |
        | Employee Contributions  | £47.08 | £47.08                  | £58.85           |
        | Including tax relief of | £9.42  | £9.42                   | £11.77           |
        | Employer Contributions  | £11.77 | £23.54                  | £35.31           |
        | TOTAL Contributions     | £58.85 | £70.62                  | £94.16           |


    Scenario: When employer contribution is above default
      And my employer contribution is "5"
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now    | April 2018 - March 2019 | Apr 2019 onwards |
        | Employee Contributions  | £11.77 | £35.31                  | £58.85           |
        | Including tax relief of | £2.35  | £7.06                   | £11.77           |
        | Employer Contributions  | £58.85 | £58.85                  | £58.85           |
        | TOTAL Contributions     | £70.62 | £94.16                  | £117.70          |
