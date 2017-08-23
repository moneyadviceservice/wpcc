Feature: Your Details editing
  In order to change my details,
  As a user of the WPCC tool,
  I want to be able to return to edit my choices.

Background:
  Given I am on the Your Details step

Scenario Outline: on Your Contributions page
  Given I am a "<age>" year old "<gender>"
  And my salary is "<salary>" "<salary_frequency>" with "<contribution>" contribution
  And I proceed to the next step
  When I click to edit my details
  Then I should return to the Your Details step
  And I should see my "<age>", "<gender>", "<salary>", "<selected_frequency>" and "<contribution>" in the form

  Examples:
      | age | gender | salary  | salary_frequency | contribution | selected_frequency |
      | 25  | male   | 25000   | per Year         | Minimum      | year               |
      | 35  | female | 2500    | per Month        | Full         | month              |
      | 45  | male   | 2450    | per 4 weeks      | Minimum      | fourweeks          |
      | 55  | female | 500     | per Week         | Full         | week               |
      

Scenario Outline: on Your Results page
  Given I am a "<age>" year old "<gender>"
  And my salary is "<salary>" "<salary_frequency>" with "<contribution>" contribution
  And I proceed to the next step
  And I move to your results page
  When I click to edit my details
  Then I should return to the Your Details step
  And I should see my "<age>", "<gender>", "<salary>", "<selected_frequency>" and "<contribution>" in the form

  Examples:
      | age | gender | salary  | salary_frequency | contribution | selected_frequency |
      | 25  | male   | 25000   | per Year         | Minimum      | year               |
      | 35  | female | 2500    | per Month        | Full         | month              |
      | 45  | male   | 2450    | per 4 weeks      | Minimum      | fourweeks          |
      | 55  | female | 500     | per Week         | Full         | week               |
