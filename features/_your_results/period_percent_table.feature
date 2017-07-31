Feature:
  As a user who has just completed the WPCC tool, I should be able to see helpful information on how the yearly increments is done.

  Scenario: Display the minimum contribution percents information table
    Given I am on the Your Details step
    And I complete the your details form and move to your contributions page
    And I fill in my contributions:
        | your_contribution | employer_contribution |
        | 1                 | 1                     |

    And I move on to the results page
    Then I should see a link to the legal minimum contributions table
    And I should see a table with a column heading for each period
    And I should see in the percents information table:
        | %1.00 | %3.00 | %5.00 |
        | %1.00 | %2.00 | %3.00 |
