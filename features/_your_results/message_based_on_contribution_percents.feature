Feature: Display messaging based on results table shown in results
  In order to better understand my results,
  As a user of the WPCC tool,
  I want to see explanation of my pension contribution

  Background:
    Given I have valid details

  Scenario Outline: Employee and Employer contributions are greater than the minimum for 2018 AND 2019
    Given I fill in my contributions:
      | your_contribution | employer_contribution |
      | 5                 | 3                     |
    When I move on to the results page
    Then I should see a contribution explanation "<message>"

    Examples:
      | message |
      | Both you and your employer are already paying above the new minimums so we have just shown the current contributions. These won't change unless your salary increases or you and/or your employer choose to pay more. |

    @welsh
    Examples:
      | message |
      | Rydych chi a'ch cyflogwr eisoes yn talu mwy na'r isafswm newydd, felly rydym wedi dangos y cyfraniadau cyfredol yn unig. Ni fydd y rhain yn newid oni bai bod eich cyflog yn cynyddu neu rydych chi ac/neu eich cyflogwr yn dewis talu mwy. |

  Scenario Outline: Employee and Employer contributions are greater than the minimum for 2018 but NOT for 2019
    Given I fill in my contributions:
      | your_contribution | employer_contribution |
      | 3                 | 2.99                  |
    When I move on to the results page
    Then I should see a contribution explanation "<message>"

    Examples:
      | message |
      | Both you and your employer are already paying above the new minimum for April 2018 so we have only shown the increase for April 2019. |

    @welsh
    Examples:
      | message |
      | Rydych chi a'ch cyflogwr eisoes yn talu mwy na'r isafswm newydd ar gyfer Ebrill 2018 felly rydym wedi dangos y cynnydd ar gyfer Ebrill 2019 yn unig. |

  Scenario Outline: Only Employee contribution is greater than the minimum for 2018 AND 2019
    Given I fill in my contributions:
      | your_contribution | employer_contribution |
      | 5                 | 1                     |
    When I move on to the results page
    Then I should see a contribution explanation "<message>"

    Examples:
      | message |
      | You are already paying above the new minimums so we have just shown how your employer's contributions will increase. Your contributions won't change unless your salary increases or you choose to pay more. |

    @welsh
    Examples:
      | message |
      | Rydych chi eisoes yn talu mwy na'r isafswm newydd, felly rydym wedi dangos sut fydd cyfraniadau eich cyflogwr yn cynyddu yn unig. Ni fydd eich cyfraniadau yn newid oni bai bod eich cyflog yn cynyddu neu os ydych yn dewis talu mwy. |

  Scenario Outline: Only Employer contribution is greater than the minimum for 2018 AND 2019
    Given I fill in my contributions:
      | your_contribution | employer_contribution |
      | 1                 | 3                     |
    When I move on to the results page
    Then I should see a contribution explanation "<message>"

    Examples:
      | message |
      | Your employer is already paying above the new minimums so we have just shown how your contributions will increase. Your employer's contribution won't change unless your salary increases or your employer chooses to pay more. |

    @welsh
    Examples:
      | message |
      | Mae eich cyflogwr eisoes yn talu mwy na'r isafswm newydd, felly rydym wedi dangos sut fydd eich cyfraniadau chi yn cynyddu yn unig. Ni fydd cyfraniad eich cyflogwr yn newid oni bai bod eich cyflog yn cynyddu neu rydych chi neu eich cyflogwr yn dewis talu mwy. |
