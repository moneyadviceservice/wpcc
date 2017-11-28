Feature: Conditional messaging for users earning £5876 - £10,000 (inclusive)
  In order to understand that I will need to actively opt-in to my workplace's workplace pension scheme,
  As a worker earning between £5876 and £10,000 (inclusive)
  I want to be notified that I won't be automatically enrolled like my higher earning colleagues
    so that I can take the appropriate action with my employer.

  Background:
  Given I am on the Your Details step
  And I fill in my details

  @no-javascript
  Scenario Outline: Viewing my details on step 2 and my salary is below the Manual Opt In limits
    And my salary is "<salary>" "<salary_frequency>" with "Full" contribution
    And I submit my details
    Then I should see the salary less than the threshold "<message>"

    Examples:
      | salary  | salary_frequency | message                                                                                                                                                                           |
      | 5875.99 | per year         | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will not be obliged to make contributions. |
      | 489.99  | per month        | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will not be obliged to make contributions. |
      | 451.99  | per 4 weeks      | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will not be obliged to make contributions. |
      | 112.99  | per week         | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will not be obliged to make contributions. |

    @welsh
    Examples:
      | salary   | salary_frequency | message                                                                                                                                                         |
      | 5875.99  | y flwyddyn       | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, ni fydd yn ofynnol i'ch cyflogwr wneud cyfraniadau. |
      | 489.99   | y mis            | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, ni fydd yn ofynnol i'ch cyflogwr wneud cyfraniadau. |
      | 451.99   | fesul 4 wythnos  | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, ni fydd yn ofynnol i'ch cyflogwr wneud cyfraniadau. |
      | 112.99   | y wythnos        | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, ni fydd yn ofynnol i'ch cyflogwr wneud cyfraniadau. |

  @no-javascript
  Scenario Outline: Viewing my details on step 2 and my salary is between the Manual Opt In limits
    And my salary is "<salary>" "<salary_frequency>" with "Full" contribution
    And I submit my details
    Then I should see the salary between thresholds "<message>"

    Examples:
     | salary  | salary_frequency | message                                                                                                                                                         |
     | 10000   | per year         | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
     | 490     | per month        | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
     | 452     | per 4 weeks      | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |
     | 113     | per week         | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. If you do so, your employer will make contributions. |

    @welsh
    Examples:
      | salary   | salary_frequency  | message                                                                                                                                                         |
      | 10000    | y flwyddyn        | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |
      | 490      | y mis             | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |
      | 452      | fesul 4 wythnos   | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |
      | 113      | y wythnos         | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno. Os felly, bydd eich cyflogwr yn gwneud cyfraniadau. |

  @no-javascript
  Scenario Outline: Viewing my details on step 2 and my salary is above the Manual Opt In limits
    And my salary is "<salary>" "<salary_frequency>" with "Full" contribution
    And I submit my details
    Then I should not see any salary "<message>"

    Examples:
      | salary    | salary_frequency | message                                                                                                    |
      | 10000.01  | per year         | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. |
      | 833.01    | per month        | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. |
      | 768.01    | per 4 weeks      | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. |
      | 192.01    | per week         | Your employer will not automatically enrol you into a workplace pension scheme but you can choose to join. |

    @welsh
    Examples:
      | salary   | salary_frequency  | message                                                                                                    |
      | 10000.01 | y flwyddyn        | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno.|
      | 833.01   | y mis             | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno.|
      | 768.01   | fesul 4 wythnos   | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno.|
      | 192.01   | y wythnos         | Ni fydd eich cyflogwr yn eich cofrestru yn awtomatig am gynllun pensiwn gweithle, ond gallwch ddewis ymuno.|

