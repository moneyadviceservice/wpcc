module Wpcc
  class ContributionsCalendar
    attr_reader :eligible_salary,
                :salary_frequency,
                :employee_percent,
                :employer_percent

    PERIODS_FILE = Wpcc::Engine.root.join('config', 'contribution_periods.yml')
    PERIODS = YAML.load_file(PERIODS_FILE)

    def initialize(eligible_salary:,
                   employee_percent:,
                   employer_percent:,
                   salary_frequency:)

      @eligible_salary = eligible_salary
      @employee_percent = employee_percent
      @employer_percent = employer_percent
      @salary_frequency = salary_frequency
    end

    def schedule
      periods.map do |_, period|
        period.symbolize_keys!
        if period[:employee_percent] && period[:employer_percent]
          calculate_contribution(period[:employee_percent],
                                 period[:employer_percent],
                                 period[:tax_relief_percent])
        else
          calculate_contribution(employee_percent,
                                 employer_percent,
                                 period[:tax_relief_percent])
        end
      end
    end

    private

    def periods
      PERIODS
    end

    def calculate_contribution(employee_percent,
                               employer_percent,
                               tax_relief_percent)
      period_args = {
        employee_percent: employee_percent,
        employer_percent: employer_percent,
        tax_relief_percent: tax_relief_percent
      }
      Wpcc::PeriodContributionCalculator.new(eligible_salary,
                                             salary_frequency,
                                             period_args).contribution
    end
  end
end
