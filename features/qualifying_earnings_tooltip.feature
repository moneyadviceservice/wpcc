Feature: Qualifying earnings tooltip
  As a user of the WPCC Tool
  In order to gain a clear understanding of financial jargons
  I want to be able to read further information through tooltips

  Background:
    Given I am on the Your Details step
    When I fill in my details

  Scenario: Show qualifying earnings tooltip on your contribution page
    And I choose to make minimum contributions
    And I click the Next button
    Then I should see a tooltip next to the qualifying earnings text

  Scenario: Hide qualifying earnings tooltip on your contribution page
    And I choose to make full contributions
    And I click the Next button
    Then I should not see a tooltip next to the qualifying earnings text

  Scenario: Show qualifying earnings tooltip on your results page
    And I choose to make minimum contributions
    And I move to your contribution step
    And I press next and move to your result step
    Then I should see a tooltip next to the qualifying earnings text

  Scenario: Hide qualifying earnings tooltip on your results page
    And I choose to make full contributions
    And I move to your contribution step
    And I press next and move to your result step
    Then I should not see a tooltip next to the qualifying earnings text
