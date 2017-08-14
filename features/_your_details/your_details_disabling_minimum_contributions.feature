Feature: Your Details disabling minimum contribution
  In order to ensure the accuracy of my contribution calculation,
  As a user of the WPCC tool, with a salary below £5,876.00pa,
  I should only be allowed to proceed with full employer contributions.

  @no-javascript
  Scenario Outline: Annual salary rate below £5,876 with minimum employer contributions
    Given I am on the Your Details step
    And I enter my details
    And I enter a "<salary>" below the minimum threshold
    And I select a valid "<salary_frequency>"
    And I choose to make minimum contributions
    When I submit my details
    Then I should see that the full contribution option should be selected
    And I should see the salary below threshold "<callout_message>" 

    Examples:
      | salary | salary_frequency | callout_message                                                                       |
      | 5000   | per Year         | At your earnings level, you will have to make contributions based on your full salary |
      | 450    | per 4 weeks      | At your earnings level, you will have to make contributions based on your full salary |
      | 480    | per Month        | At your earnings level, you will have to make contributions based on your full salary |
      | 70     | per Week         | At your earnings level, you will have to make contributions based on your full salary |

  @no-javascript
  Scenario: Annual salary rate below £5,876 with full employer contributions
    Given I am on the Your Details step
    When I enter my details
    And I enter a salary below the minimum threshold
    And I choose to make full contributions
    And I submit my details
    Then I should be able to proceed to the next page
