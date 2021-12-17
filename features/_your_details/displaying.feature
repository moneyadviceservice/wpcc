Feature: Your Details displaying
  In order to confirm my inputs are correct as I progress through the tool,
  As a user of the WPCC tool,
  I want to see my details that I filled in on step one.

Scenario Outline: Display input details on later steps
  Given I am on the Your Details step
  When I enter my age as "<age>"
  And I select my salary frequency as "<salary_frequency>"
  And I choose my contribution preference as "<contribution_preference>"
  And I enter my salary as "<salary>"
  And I proceed to the next step
  Then I should see "<my_details>" summarised

  Examples:
    | age | salary_frequency | salary | contribution_preference | my_details                                                         |
    | 23  | per year         | 6240   | Minimum                 | 23 years, £6,240 per year, part salary                             |

  @welsh
  Examples:
    | age | salary_frequency | salary | contribution_preference | my_details                                                    |
    | 34  | fesul 4 wythnos  | 36000  | Minimum                 | 34 blynyddoedd, £36,000 fesul 4 wythnos, nghyflog rhan Golygu |
