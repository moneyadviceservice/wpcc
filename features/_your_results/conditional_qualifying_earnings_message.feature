Feature: Additional message depending on your contribution preference
  As a user looking at Your Results page,
  In order to understand what the tool is doing,
  I would like to see that my results are calculated on a figure based on my selections

  Background:
    Given I am on the Your Details step
    And I fill in my details

    Scenario Outline: When is Minimum contribution
      Given I choose my contribution preference as "Minimum"
      When I click the Next button
      And I move on to the results page
      Then I should see a contribution explanation "<message>"

      Examples:
        | message |
        | Contributions will be based on your qualifying earnings i show help of £28,760 per year |

      @welsh
      Examples:
        | message |
        | Bydd cyfraniadau yn seiliedig ar eich enillion cymwys i sioe help o £28,760 y flwyddyn. |

    Scenario Outline: When is Full Contribution
      Given I choose my contribution preference as "Full"
      When I click the Next button
      And I move on to the results page
      Then I should see a contribution explanation "<message>"

      Examples:
        | message |
        | Contributions will be based on your salary of £35,000 per year |

      @welsh
      Examples:
        | message |
        | Bydd cyfraniadau yn seiliedig ar eich cyflog o £35,000 y flwyddyn. |
