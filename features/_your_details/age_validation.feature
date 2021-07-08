Feature: Display validation messages for age
  As a user of the Workplace Pension Contribution Calculater tool
  In order to get a clearer idea on how to progress through the app
  I want to receive helpful messages that clearly explains where I may be going wrong

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
      | English  | 75  | You are not entitled to be automatically enrolled into a workplace pension. Many of the tax benefits of saving into a pension stop at age 75. |

    @welsh
    Examples:
      | language | age | validation_message |
      | Welsh    | 80  | Nid oes gennych hawl i gael eich ymrestru'n awtomatig mewn pensiwn gweithle. Mae llawer o'r buddion treth o gynilo i mewn i gynllun pensiwn yn stopio yn 75 oed. |
