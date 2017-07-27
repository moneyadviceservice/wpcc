Feature: Contributions - employer contributions for low salary
  In order to ensure the accuracy of my contribution calculation,
  As a user of the WPCC tool, and my salary is below £5,876.00pa,
  I should only be allowed to proceed with full employer contributions.

  @no-javascript
  Scenario Outline: Annual salary rate below £5,876 with minimum employer contributions
    Given I am on step 1 of the WPCC homepage
    When  I enter my details
    And   I enter a "<salary>" below the minimum threshold
    And   I select a valid "<salary_frequency>"
    And   I choose to make minimum contributions
    And   I submit my details
    Then  I should not be able to choose to make minimum employer contributions

    Examples:
      | salary | salary_frequency |
      | 5000   | per Year         |
      | 450    | per 4 weeks      |
      | 480    | per Month        |
      | 70     | per Week         |

  @no-javascript
  Scenario: Annual salary rate below £5,876 with full employer contributions
    Given I am on step 1 of the WPCC homepage
    When  I enter my details
    And   I enter a salary below the minimum threshold
    And   I choose to make full contributions
    And   I submit my details
    Then  I should be able to proceed to the next page
