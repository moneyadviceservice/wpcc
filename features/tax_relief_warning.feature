Feature: Display Tax Relief Warning
  As a user earning below £11,500 per year
  I need to understand that my contributions will only result in tax relief under certain circumstances
  So that I can make an informed decision about the impact of contributions on my take-home pay

  @no-javascript
  Scenario Outline: Earnings below £11,500 per year
    Given that I am on the WPCC homepage in my own "<language>"
    When  I enter my personal details
    And   I enter a "<salary>" below the salary band
    And   I submit my details
    And   I progress to the results page
    Then  I should see tax relief "<warning_message>"

    Examples:
      | language | salary | warning_message |
      | Welsh    | 11000  | Os nad ydych chi'n talu treth incwm ar eich enillion, fyddwch chi ddim ond yn cael gostyngiad treth ar eich cyfraniadau |
      | English  | 11000  | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions |
