Feature: Conditional messaging for users earning £5876 - £10,000 (inclusive)
  As a worker earning between £5876 and £10,000 (inclusive)
  I need to understand that I will need to actively opt-in to my workplace's workplace
  pension scheme, and will not be automatically enrolled like my higher earning
  colleagues so that I can take the appropriate action with my employer.

  @no-javascript
  Scenario Outline: Viewing my details on step 2 and my salary is between £5,876 and £10,000
    Given that I am on the WPCC homepage in my own "<language>"
    When  I enter my age "<gender>" and "<salary_frequency>" 
    And   I choose to make the minimum contribution
    And   I enter a "<salary>" between the salary band
    And   I submit my details
	  Then  I should be able to proceed to the next page
    And   I should see the manually_opt_in "<message>" in my own language

    Examples:
      | language | gender    | salary_frequency | salary | message                                                                                                                                                         |
      | English  | Female    | per Year         | 6000   | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
      | Welsh    | Benywaidd | y Flwyddyn       | 6000   | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

  @no-javascript
  Scenario Outline: Viewing my details on step 2 and my salary is above £10,000
    Given that I am on the WPCC homepage in my own "<language>"
    When  I enter my age "<gender>" and "<salary_frequency>" 
    And   I enter a "<salary>" above the upper salary threshold
    And   I choose to make the minimum contribution
    And   I submit my details
	  Then  I should be able to proceed to the next page
    And   I should not see the manually_opt_in "<message>"

    Examples:
      | language | gender    | salary_frequency | salary  | message                                                                                                                                                         |
      | English  | Female    | per Year         | 10001   | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
      | Welsh    | Benywaidd | y Flwyddyn       | 10001   | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

  @no-javascript
  Scenario Outline: Viewing my details on step 2 and my salary is below £5,876
    Given that I am on the WPCC homepage in my own "<language>"
    When  I enter my age "<gender>" and "<salary_frequency>"
    And   I enter a "<salary>" below the low salary threshold
    And   I choose to make the full contribution
    And   I submit my details
    Then  I should be able to proceed to the next page
    And   I should not see the manually_opt_in "<message>"

    Examples:
      | language | gender    | salary_frequency | salary | message                                                                                                                                                         |
      | English  | Female    | per Year         | 5875   | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
      | Welsh    | Benywaidd | y Flwyddyn       | 5875   | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

  @no-javascript
  Scenario Outline: Viewing my details on step 3
    Given I am on step 1 of the WPCC homepage
    When  I enter my details with a salary within manually_opt_in range and submit the form
    And   I submit the Your Contributiions form and proceed to Your Results
    Then  I should not see the manually_opt_in "<message>"

    Examples:
      | language | message                                                                                                                                                         |
      | English  | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to  join. If you do so, your employer will make contributions.|
      | Welsh    | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |
