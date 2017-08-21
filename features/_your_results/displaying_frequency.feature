Feature: Displaying frequency in the results table
  In order to fully understand what I will be paying and how often
  As a user trying to work out the impact of my contributions on my take-home pay
  I want to see the frequency being displayed clearly on my results

  Background:
    Given I am on the Your Details step
    And I am a "25" year old "male"

  Scenario: Displaying weekly
    Given my salary is "200" "per Week" with "Minimum" contribution
    And I click the Next button
    When I move on to the results page
    Then my results should all read:
      | Your weekly contribution       |
      | Employer's weekly contribution |
      | Total weekly contributions     |

 Scenario: Displaying 4-weekly
    Given my salary is "1200" "per 4 weeks" with "Minimum" contribution
    And I click the Next button
    When I move on to the results page
    Then my results should all read:
      | Your 4-weekly contribution       |
      | Employer's 4-weekly contribution |
      | Total 4-weekly contributions     |

 Scenario: Displaying monthly
    Given my salary is "1500" "per Month" with "Minimum" contribution
    And I click the Next button
    When I move on to the results page
    Then my results should all read:
      | Your monthly contribution       |
      | Employer's monthly contribution |
      | Total monthly contributions     |

 Scenario: Display annual when "per Year" frequency selected on Step 3
    Given my salary is "20000" "per Year" with "Minimum" contribution
    And I click the Next button
    And I move on to the results page
    When I select "per Year" to change the calculations
    And I press recalculate
    Then my results should all read:
      | Your annual contribution       |
      | Employer's annual contribution |
      | Total annual contributions     |
