Feature: Conditional messaging for users earning £5876 - £10,000 (inclusive)
  As a worker earning between £5876 and £10,000 (inclusive)
  I need to understand that I will need to actively opt-in to my workplace's workplace
  pension scheme, and will not be automatically enrolled like my higher earning
  colleagues so that I can take the appropriate action with my employer.


  @no-javascript
  Scenario Outline: salary earning is between £5,876 and £10,000
    Given that I am on the WPCC homepage in my own "<language>"
    When  I enter my personal details
    And   I enter a "<salary>" between the salary band
    And   I submit my details
	  Then  I should be able to proceed to the next page
    And   I should see the auto-enrolment "<conditional_message>" in my own language

    Examples:
      | language | salary | conditional_message                                                                                                                                             |
      | en       | 6000   | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
      | cy       | 6000   | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

  Scenario Outline: salary earning is lower than the lower threshold of £5,876
    Given that I am on the WPCC homepage in my own "<language>"
    When  I enter my personal details
    And  I enter a "<salary>" below the low salary threshold
    And  I choose not to make minimum contributions
	  Then I should be able to proceed to the next page
    And  I should not see the auto-enrolment "<conditional_message>"
