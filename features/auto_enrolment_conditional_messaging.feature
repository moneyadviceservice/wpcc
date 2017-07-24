Feature: Conditional messaging for users earning £5876 - £10,000 (inclusive)
  As a worker earning between £5876 and £10,000 (inclusive)
  I need to understand that I will need to actively opt-in to my workplace's workplace
  pension scheme, and will not be automatically enrolled like my higher earning
  colleagues so that I can take the appropriate action with my employer.


  @no-javascript
  Scenario Outline: salary earning is between £5,876 and £10,000
    Given that I am on the WPCC homepage in my own "<language>"
    When  I enter my age "<gender>" and "<salary_frequency>" 
    And   I choose to make the minimum contribution
    And   I enter a "<salary>" between the salary band
    And   I submit my details
	  Then  I should be able to proceed to the next page
    And   I should see the auto-enrolment "<conditional_message>" in my own language

    Examples:
      | language | gender    | salary_frequency | salary | conditional_message                                                                                                                                             |
      | English  | Female    | per Year         | 6000   | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
      | Welsh    | Benywaidd | y Flwyddyn       | 6000   | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

  Scenario Outline: salary earning is above the upper threshold of £10,000
    Given that I am on the WPCC homepage in my own "<language>"
    When  I enter my age "<gender>" and "<salary_frequency>" 
    And   I enter a "<salary>" above the upper salary threshold
    And   I choose to make the minimum contribution
    And   I submit my details
	  Then  I should be able to proceed to the next page
    And   I should not see the auto-enrolment "<conditional_message>"

    Examples:
      | language | gender    | salary_frequency | salary  | conditional_message                                                                                                                                             |
      | English  | Female    | per Year         | 10001   | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
      | Welsh    | Benywaidd | y Flwyddyn       | 10001   | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |


  Scenario Outline: salary earning is below the lower threshold of £5,876
    Given that I am on the WPCC homepage in my own "<language>"
    When  I enter my age "<gender>" and "<salary_frequency>"
    And   I enter a "<salary>" below the low salary threshold
    And   I choose to make the full contribution
    And   I submit my details
    Then  I should be able to proceed to the next page
    And   I should not see the auto-enrolment "<conditional_message>"

    Examples:
      | language | gender    | salary_frequency | salary | conditional_message                                                                                                                                             |
      | English  | Female    | per Year         | 5875   | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
      | Welsh    | Benywaidd | y Flwyddyn       | 5875   | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

