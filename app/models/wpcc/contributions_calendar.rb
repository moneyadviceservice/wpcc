module Wpcc
  class ContributionsCalendar
    attr_reader :eligible_salary, :salary_frequency
    attr_reader :employee_percent, :employer_percent

    def initialize(eligible_salary:, 
                   employee_percent:, 
                   employer_percent:,
                   salary_frequency: )

      @eligible_salary = eligible_salary
      @employee_percent = employee_percent
      @employer_percent = employer_percent
      @salary_frequency = salary_frequency
    end

    PERIODS_FILE = Wpcc::Engine.root.join('config', 'contribution_periods.yml')
    PERIODS = YAML.load_file(PERIODS_FILE)
    
    def schedule
      periods.map do |_, period|
        if period[:employee_percent] && period[:employer_percent]
          calculate_contribution(period[:employee_percent], 
                                period[:employer_percent]
          )
        else
          calculate_contribution(employee_percent, employer_percent)
        end
      end
    end

    private

    def periods
      PERIODS
    end

    def calculate_contribution(employee_percent, employer_percent)
      PeriodContribution.new(eligible_salary, 
                             salary_frequency, 
                             employee_percent,
                             employer_percent)
    end
  end
end
