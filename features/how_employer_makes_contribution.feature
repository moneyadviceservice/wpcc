Feature: Employment contribution
  As a Workplace Pensions Contribution Calculator user
  In order to ensure the accuracy of my contribution calculation.
  I should not be able to proceed to the next step
  And I should be notified why I am unable to proceed.

  @no-javascript
  Scenario Outline: Annual salary rate below £5,876 with minimum employer contributions
    Given that I am on the WPCC homepage
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
    Given that I am on the WPCC homepage
    When  I enter my details
    And   I enter a salary below the minimum threshold
    And   I choose to make full contributions
    And   I submit my details
    Then  I should be able to proceed to the next page
