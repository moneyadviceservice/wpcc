Feature:
  As a user of the WPCC tool,
  In order to confirm my inputs are correct as I progress through the tool,
  I want to see the information that I filled in on Step 2

Scenario:
  Given that I have completed the first of the WPCC tool
  When I have input % values on the second step
  And  I move on to the results page
  Then I should see both of those values summarised next to the heading for the second step