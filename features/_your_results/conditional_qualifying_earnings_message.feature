Feature: Additional message depending on your contribution preference
  As a user looking at Your Results page,
  In order to understand what the tool is doing,
  I would like to see that my results are calculated on a figure based on my selections

  Background:
    Given I am on the Your Details step
    And I fill in my details

    Scenario Outline: Display message when selecting minimum contribution
      Given I choose my contribution preference as "Minimum"
      When I click the Next button
      And I move on to the results page
      Then I should see a contribution explanation "<message>"

      Examples:
        | message |
        | Contributions will be made on your qualifying earnings of £29,124 per year |

      @welsh
      Examples:
        | message |
        | Bydd cyfraniadau yn seiliedig ar eich enillion cymwys o £29,124 y flwyddyn. |

    Scenario Outline: Display message when selecting full salary contribution
      Given I choose my contribution preference as "Full"
      When I click the Next button
      And I move on to the results page
      Then I should see a contribution explanation "<message>"

      Examples:
        | message |
        | Contributions will be made on your salary of £35,000 per year |

      @welsh
      Examples:
        | message |
        | Bydd cyfraniadau yn seiliedig ar eich cyflog o £35,000 y flwyddyn. |
