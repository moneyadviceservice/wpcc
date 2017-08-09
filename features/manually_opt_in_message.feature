Feature: Conditional messaging for users earning £5876 - £10,000 (inclusive)
  In order to understand that I will need to actively opt-in to my workplace's workplace pension scheme,
  As a worker earning between £5876 and £10,000 (inclusive)
  I want to be notified that I won't be automatically enrolled like my higher earning colleagues
    so that I can take the appropriate action with my employer.


  Background:
  Given I am on the Your Details step
  And I fill in my details

  @no-javascript
  Scenario Outline: Viewing my details on step 2 and my salary is between £5,876 and £10,000
    And I enter my salary as "6000"
    And I submit my details
    And I should see the manually_opt_in "<message>"

    Examples:
      | message                                                                                                                                                         |
      | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |

    @welsh
    Examples:
      | message                                                                                                                                                         |
      | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

  @no-javascript
  Scenario Outline: Viewing my details on step 2 and my salary is above £10,000
    And I enter my salary as "10001"
    And I submit my details
    And I should not see the manually_opt_in "<message>"

    Examples:
      | message                                                                                                                                                         |
      | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |

    @welsh
    Examples:
      | message                                                                                                                                                         |
      | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

  @no-javascript
  Scenario Outline: Viewing my details on step 2 and my salary is below £5,876
    And I enter my salary as "5875"
    And I choose to make the full contribution
    And I submit my details
    And I should not see the manually_opt_in "<message>"

    Examples:
      | message                                                                                                                                                         |
      | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |

    @welsh
    Examples:
      | message                                                                                                                                                         |
      | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

  @no-javascript
  Scenario Outline: Viewing my details on step 3
    And I enter my salary as "8500"
    And I submit my details
    And I submit the Your Contributiions form and proceed to Your Results
    Then I should not see the manually_opt_in "<message>"

    Examples:
      | message                                                                                                                                                         |
      | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to  join. If you do so, your employer will make contributions.|

    @welsh
    Examples:
      | message                                                                                                                                                         |
      | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |
