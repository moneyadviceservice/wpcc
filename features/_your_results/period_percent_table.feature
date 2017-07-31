Feature:
  As a user who has just completed the WPCC tool, I should be able to see helpful information on how the yearly increments is done. 

  Scenario: Display table of percentages for each period
    Given I am on the YourDetailsPage
    When I fill in my details
    And I click the Next button
    And I move on to the results page
    Then I should see a table of percents for each periods
