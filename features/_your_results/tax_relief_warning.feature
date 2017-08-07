Feature: Display Tax Relief Warning
  As a user earning below £11,500 per year
  I need to understand that my contributions will only result in tax relief under certain circumstances
  So that I can make an informed decision about the impact of contributions on my take-home pay

  Background:
    Given I am on the Your Details step
    When I enter my personal details

  @no-javascript
  Scenario Outline: Earning below £11,500 per year
    And my salary is "<salary>" "<salary_frequency>"
    And I progress to the results page
    Then I should see tax relief "<warning_message>"

    Examples:
      | salary | salary_frequency | warning_message |
      | 11000  | per Year         | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |
      | 858.33 | per Month        | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |
      | 784.61 | per 4 weeks      | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |
      | 121.14 | per Week         | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |

    @welsh
    Examples:
      | salary | salary_frequency | warning_message |
      | 11000  | y Flwyddyn       | Os nad ydych chi'n talu treth incwm ar eich enillion, fyddwch chi ddim ond yn cael gostyngiad treth ar eich cyfraniadau |

  @no-javascript
  Scenario Outline: Earning £11,500 per year
    And my salary is "<salary>" "<salary_frequency>"
    And I progress to the results page
    Then  I should NOT see tax relief "<warning_message>"

    Examples:
      | salary | salary_frequency | warning_message |
      | 11500  | per Year         | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |
      | 958.33 | per Month        | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |
      | 884.61 | per 4 weeks      | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |
      | 221.15 | per Week         | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |

    @welsh
    Examples:
      | salary | salary_frequency | warning_message |
      | 11500  | y Flwyddyn       | Os nad ydych chi'n talu treth incwm ar eich enillion, fyddwch chi ddim ond yn cael gostyngiad treth ar eich cyfraniadau |

  @no-javascript
  Scenario Outline: Earning above £11,500 per year
    And my salary is "<salary>" "<salary_frequency>"
    And I progress to the results page
    Then  I should NOT see tax relief "<warning_message>"

    Examples:
      | salary | salary_frequency | warning_message |
      | 11501  | per Year         | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |
      | 959.33 | per Month        | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |
      | 885.61 | per 4 weeks      | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |
      | 222.14 | per Week         | If you don’t pay income tax on your earnings, you will only receive tax relief on your pension contributions            |

    @welsh
    Examples:
      | salary | salary_frequency | warning_message |
      | 11501  | y Flwyddyn       | Os nad ydych chi'n talu treth incwm ar eich enillion, fyddwch chi ddim ond yn cael gostyngiad treth ar eich cyfraniadau |

