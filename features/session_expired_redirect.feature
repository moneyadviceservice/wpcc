Feature: Redirect to your details step when there is no session
  As a Workplace Pension Contribution Calculator user
  I need to be sent back to your details step if I go direct to other steps
  So that I can enter my details first to get my pension contributions

  Scenario: Redirect when visiting Your contributions step directly
    When I visit your contributions step directly
    Then I should return to the Your Details step

  Scenario: Redirect when visiting Your results step directly
    When I visit Your results step directly
    Then I should return to the Your Details step
