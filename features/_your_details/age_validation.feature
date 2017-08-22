Feature: Display validation messages for age
  As a user of the Workplace Pension Contribution Calculater tool
  In order to get a clearer idea on how to progress through the app
  I want to receive helpful messages that clearly explains where I may be going wrong

  """ Background
    Add server-side validation messages to page 1 for user-selections that should not allow the user to progress without amending or checking their inputs.
    These messages should be placed underneath the affected input. and be highlighted by being red in colour.
  """

  @no-javascript
  Scenario Outline: Younger than the minimum age of 16 years
    Given I am on the Your Details step
    When I fill in my details
    And I enter my age as "<age>"
    And I proceed to the next step
    Then I should NOT be able to progress to the next page
    And I should see the "<validation_message>" for age

    Examples:
      | age | validation_message                              |
      | 15  | You are too young to join a workplace pension   |

    @welsh
    Examples:
      | age | validation_message                              |
      | 10  | Rydych yn rhy ifanc i ymuno â phensiwn gweithle |

  @no-javascript
  Scenario Outline: Older than the maximum age of 74 years
    Given I am on the Your Details step
    When I fill in my details
    And I enter my age as "<age>"
    And I proceed to the next step
    Then I should NOT be able to progress to the next page
    And I should see the "<validation_message>" for age

    Examples:
      | language | age | validation_message |
      | English  | 75  | You are not eligible to join a workplace pension because you are above the maximum age |

    @welsh
    Examples:
      | language | age | validation_message |
      | Welsh    | 80  | Nid ydych yn gymwys i ymuno â phensiwn gweithle gan eich bod yn hŷn na’r uchafswm oed |
