Feature: Informing about contribution percentages
  In order to gain a better understanding of how my workplace pension is being calculated,
  As a user of the WPCC tool,
  I want to see relevant information about the contributions my employer and I can make.

Background:
  Given I am on the Your Details step
  When I fill in my details

Scenario Outline: minimum contribution percentage on salary greater than £5,876
  And I enter my salary as "6000"
  And I proceed to the next step
  And the "employee" contribution intro should display "<message>"
  And the "employer" contribution intro should display "<message>"

  Examples:
    | message                 |
    | The legal minimum is 1% |

  @welsh
  Examples:
    | message                      |
    | Yr isafswm cyfreithiol yw 1% |

Scenario Outline: minimum contribution percentage on salary less than £5,876
  And I enter a salary below the minimum threshold
  And I choose to make full contributions
  And I proceed to the next step
  Then I should NOT see an intro for employer contributions
  Then the "employee" contribution intro should display "<message>"

  Examples:
    | message                                                     |
    | At your salary level there is no legal minimum contribution |

  @welsh
  Examples:
    | message                                           |
    | Ar eich lefel cyflog, nid oes isafswm cyfreithiol |