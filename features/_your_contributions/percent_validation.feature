Feature: Informing about contribution percentages
  In order to gain a better understanding of how my workplace pension is being calculated,
  As a user of the WPCC tool,
  I want to see relevant information about the contributions my employer and I can make.

Background:
  Given I am on the Your Details step
  When I fill in my details

Scenario Outline: minimum contribution percentage on salary less than £6,032
  And I enter a salary below the minimum threshold
  And I choose to make full contributions
  And I proceed to the next step
  Then I should NOT see an intro for employer contributions
  Then the "employee" contribution intro should display "<message>"
  Then the employee contribution displays "<employee_default>" percent

  Examples:
    | message                                                     | employee_default |
    | At your salary level there is no legal minimum contribution | 4.0              |

  @welsh
  Examples:
    | message                                           | employee_default |
    | Ar eich lefel cyflog, nid oes isafswm cyfreithiol | 4.0              |
