Feature: Details - displayed in future steps
  In order to confirm my inputs are correct as I progress through the tool,
  As a user of the WPCC tool,
  I want to see my details that I filled in on the step one.

Background:
  Given I am on step 1 of the WPCC homepage
  When I fill in the age, gender, salary and frequency fields

Scenario: Display minimum contribution details
  And I click on "My employer makes contributions on part of my salary"
  And I click the Next button
  Then I should see my age, gender, salary, frequency and contribution option

Scenario: Display full pay contribution details
  And I click on "My employer makes contributions on all of my salary"
  And I click the Next button
  Then I should see in English my age, gender, salary, frequency and full pay
