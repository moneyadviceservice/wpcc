Feature: calculating qualifying earnings
  In order to gain a better understanding of how my workplace pension is being calculated,
  As a user of the WPCC tool,
  I want to see the qualifying earnings on which my contributions are based,
  And I want to see the default contribution percentages.

Background:
  Given I am on the Your Details step
  When I fill in my details

Scenario: Calculate on minimum contribution for salary greater than the Upper Earnings Threshold
  And my salary per year is greater than the upper earnings threshold of £45,000
  And I choose to make minimum contributions
  And I proceed to the next step
  Then I should see that my qualifying earnings is the limit of "£39,124"

Scenario: Calculate minimum contribution for salary equal to or less than the Upper Earnings Threshold
  And my salary per year is equal to or less than the upper earnings threshold of £45,000
  And I choose to make minimum contributions
  And I proceed to the next step
  Then the Your Contributions step should tell me my qualifying earnings

Scenario: Calculate on full pay equal to or more than £5876
  And I choose to make full contributions
  And I proceed to the next step
  Then the Your Contributions step should tell me my qualifying earnings are my salary
