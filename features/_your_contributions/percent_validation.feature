Feature: Informing about contribution percentages
  In order to gain a better understanding of how my workplace pension is being calculated,
  As a user of the WPCC tool,
  I want to see relevant information about the contributions my employer and I can make.

Background:
  Given I am on the Your Details step
  When I fill in my details

Scenario Outline: minimum contribution percentage on salary greater than £6,032
  And I enter my salary as "6033"
  And I proceed to the next step
  And the "employee" contribution intro should display "<employee_message>"
  And the "employer" contribution intro should display "<employer_message>"

  Examples:
    | employee_message        | employer_message        |
    | The legal minimum is 3% | The legal minimum is 2% |


  @welsh
  Examples:
    | employee_message              | employer_message             |
    | Yr isafswm cyfreithiol yw 3%  | Yr isafswm cyfreithiol yw 2% |

Scenario Outline: minimum contribution percentage on salary less than £6,032
  And I enter a salary below the minimum threshold
  And I choose to make full contributions
  And I proceed to the next step
  Then I should NOT see an intro for employer contributions
  Then the "employee" contribution intro should display "<message>"
  Then the employee contribution displays "<employee_default>" percent

  Examples:
    | message                                                     | employee_default |
    | At your salary level there is no legal minimum contribution | 3.0              |

  @welsh
  Examples:
    | message                                           | employee_default |
    | Ar eich lefel cyflog, nid oes isafswm cyfreithiol | 3.0              |
