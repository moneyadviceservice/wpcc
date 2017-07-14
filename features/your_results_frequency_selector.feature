Feature:
  As an employee, I want to be able to see my results in a frequency different to how I input my salary because I want to understand how the contributions will impact my monthly or weekly take-home pay.

  Background:
    Given I am on the YourDetailsPage
    When  I enter my age as 25
    And   I enter my gender as male
    And   My salary is 25000
    And   I select per Year salary frequency
    And   I select the minimum contribution
    And   I press next and move to your contributions step
    And   I press next and move to your result step

  Scenario Outline:
    When  I select "<salary_frequency>" salary frequency
    And   I press recalculate
    # Then  I should see contributions and tax_relief figures recalculated by <salary_frequency> frequency on the results page


  Examples:
    | salary_frequency |
    | year             |
    | month            |
    | fourweeks        |
    | week             |

  Examples:
    | employee_contributions_now | employee_contributions_next | employee_contributions_future |
    | 191.24                     | 573.72                      | 956.20                        |
    | 15.94                      | 47.81                       | 79.68                         |
    | 14.71                      | 44.13                       | 73.55                         |
    | 3.68                       | 11.03                       | 18.39                         |

  Examples:
    | tax_relief_now | tax_relief_next | tax_relief_future |
    | 38.25          | 114.74          | 191.24            |
    | 3.19           | 9.56            | 15.94             |
    | 2.94           | 8.83            | 14.71             |
    | 0.74           | 2.21            | 13.68             |

  Examples:
    | employer_contributions_now | employer_contributions_next | employer_contributions_future |
    | 191.24                     | 382.48                      | 573.72                        |
    | 15.94                      | 31.87                       | 47.81                         |
    | 14.71                      | 29.42                       | 44.13                         |
    | 3.68                       | 7.36                        | 11.03                         |

  Examples:
    | total_contributions_now | total_contributions_next | total_contributions_future |
    | 382.48                  | 956.20                   | 1529.92                    |
    | 31.87                   | 79.68                    | 127.49                     |
    | 29.42                   | 73.55                    | 117.69                     |
    | 7.36                    | 18.39                    | 29.42.                     |

