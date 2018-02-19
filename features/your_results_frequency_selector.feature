Feature:
  In order to understand how the contributions will impact my monthly or weekly take-home pay
  As an employee
  I want to be able to see my results in a frequency different to how I input my salary

  Background:
    Given I am on the Your Details step
    And I am a "25" year old "female"
    And my salary is "80000" "per year" with "Full" contribution
    And I click the Next button
    And my contribution is "10" percent
    When I move on to the results page

  @javascript
  Scenario: Recalculate results changing to monthly frequency
    When I select "per month" to change the calculations
    Then I should see the values on the results page as:
      |                         | Now     | Apr 2019 onwards |
      | Employee Contributions  | £666.67 | £666.67          |
      | Including tax relief of | £133.33 | £133.33          |
      | Employer Contributions  | £133.33 | £200.00          |
      | TOTAL contributions     | £800.00 | £866.67          |

  @no-javascript
  Scenario: Recalculate results changing to monthly frequency
    When I select "per month" to change the calculations
    And I press recalculate
    Then I should see the values on the results page as:
      |                         | Now     | Apr 2019 onwards |
      | Employee Contributions  | £666.67 | £666.67          |
      | Including tax relief of | £133.33 | £133.33          |
      | Employer Contributions  | £133.33 | £200.00          |
      | TOTAL contributions     | £800.00 | £866.67          |

  @javascript
  Scenario: Recalculate results changing to weekly frequency
    When I select "per week" to change the calculations
    Then I should see the values on the results page as:
      |                         | Now     | Apr 2019 onwards |
      | Employee Contributions  | £153.85 | £153.85          |
      | Including tax relief of | £30.77  | £30.77           |
      | Employer Contributions  | £30.77  | £46.15           |
      | TOTAL contributions     | £184.62 | £200.00          |

  @no-javascript
  Scenario: Recalculate results changing to weekly frequency
    When I select "per week" to change the calculations
    And I press recalculate
    Then I should see the values on the results page as:
      |                         | Now     | Apr 2019 onwards |
      | Employee Contributions  | £153.85 | £153.85          |
      | Including tax relief of | £30.77  | £30.77           |
      | Employer Contributions  | £30.77  | £46.15           |
      | TOTAL contributions     | £184.62 | £200.00          |

  @javascript
  Scenario: Recalculate results changing to weekly frequency
    When I select "per 4 weeks" to change the calculations
    Then I should see the values on the results page as:
      |                         | Now     | Apr 2019 onwards |
      | Employee Contributions  | £615.38 | £615.38          |
      | Including tax relief of | £123.08 | £123.08          |
      | Employer Contributions  | £123.08 | £184.62          |
      | TOTAL contributions     | £738.46 | £800.00          |

  @no-javascript
  Scenario: Recalculate results changing to weekly frequency
    When I select "per 4 weeks" to change the calculations
    And I press recalculate
    Then I should see the values on the results page as:
      |                         | Now     | Apr 2019 onwards |
      | Employee Contributions  | £615.38 | £615.38          |
      | Including tax relief of | £123.08 | £123.08          |
      | Employer Contributions  | £123.08 | £184.62          |
      | TOTAL contributions     | £738.46 | £800.00          |
