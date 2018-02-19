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
        |                         | Now    | April 2018 - March 2019 | Apr 2019 onwards |
        | Employee Contributions  | £46.56 | £46.56                  | £58.20           |
        | Including tax relief of | £9.31  | £9.31                   | £11.64           |
        | Employer Contributions  | £11.64 | £23.28                  | £34.92           |
        | TOTAL Contributions     | £58.20 | £69.84                  | £93.12           |


    Scenario: When employer contribution is above default
      And my employer contribution is "5"
      When I move on to the results page
      Then I should see the values on the results page as:
        |                         | Now    | April 2018 - March 2019 | Apr 2019 onwards |
        | Employee Contributions  | £11.64 | £34.92                  | £58.20           |
        | Including tax relief of | £2.33  | £6.98                   | £11.64           |
        | Employer Contributions  | £58.20 | £58.20                  | £58.20           |
        | TOTAL Contributions     | £69.84 | £93.12                  | £116.40          |
