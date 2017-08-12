Feature:
  In order to understand how the contributions will impact my monthly or weekly take-home pay
  As an employee
  I want to be able to see my results in a frequency different to how I input my salary

  Background:
    Given I am on the Your Details step
    And I am a "25" year old "female"
    And my salary is "80000" "per Year" with "Full" contribution
    And I click the Next button
    And my contribution is "10" percent
    When I move on to the results page

  @javascript
  Scenario: Recalculate results changing to monthly frequency
    When I select "per Month" to change the calculations
    Then I should see on the results page:
      | £666.67 | £666.67 | £666.67 |
      | £133.33 | £133.33 | £133.33 |
      | £66.67  | £133.33 | £200.00 |
      | £733.34 | £800.00 | £866.67 |

  @no-javascript
  Scenario: Recalculate results changing to monthly frequency
    When I select "per Month" to change the calculations
    And I press recalculate
    Then I should see on the results page:
      | £666.67 | £666.67 | £666.67 |
      | £133.33 | £133.33 | £133.33 |
      | £66.67  | £133.33 | £200.00 |
      | £733.34 | £800.00 | £866.67 |

  @javascript
  Scenario: Recalculate results changing to weekly frequency
    When I select "per Week" to change the calculations
    Then I should see on the results page:
      | £153.85 | £153.85 | £153.85 |
      | £30.77  | £30.77  | £30.77  |
      | £15.38  | £30.77  | £46.15  |
      | £169.23 | £184.62 | £200.00 |

  @no-javascript
  Scenario: Recalculate results changing to weekly frequency
    When I select "per Week" to change the calculations
    And I press recalculate
    Then I should see on the results page:
      | £153.85 | £153.85 | £153.85 |
      | £30.77  | £30.77  | £30.77  |
      | £15.38  | £30.77  | £46.15  |
      | £169.23 | £184.62 | £200.00 |

  @javascript
  Scenario: Recalculate results changing to weekly frequency
    When I select "per 4 weeks" to change the calculations
    Then I should see on the results page:
      | £615.39 | £615.39 | £615.39 |
      | £123.07 | £123.07 | £123.07 |
      | £61.54  | £123.07 | £184.62 |
      | £676.93 | £738.46 | £800.00 |

  @no-javascript
  Scenario: Recalculate results changing to weekly frequency
    When I select "per 4 weeks" to change the calculations
    And I press recalculate
    Then I should see on the results page:
      | £615.38 | £615.38 | £615.38 |
      | £123.08 | £123.08 | £123.08 |
      | £61.54  | £123.08 | £184.62 |
      | £676.92 | £738.46 | £800.00 |
