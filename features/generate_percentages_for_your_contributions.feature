Feature:
  As a user of the WPCC tool,
  In order to gain a better understanding of how my workplace pension is being calculated,
  I want to see the eligible salary on which my contributions are based,
  Additionally, I want to see the default contribution percentages.

Background:
  Given I am on the YourDetailsPage 

Scenario: Calculate on minimum contribution for salary equal to or less than the Upper Earnings Threshold
  When I select the minimum contribution on Step 1
  And my salary per year is equal to or less than the upper earnings threshold of £45,000
  And I press next
  Then the Step 2 intro paragraph should display my eligible salary
