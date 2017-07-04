module Wpcc
  class ContributionsCalendar
    attr_reader :eligible_salary,
                :salary_frequency,
                :employee_percent,
                :employer_percent

    PERIODS_FILE = Wpcc::Engine.root.join('config', 'contribution_periods.yml')
    PERIODS = HashWithIndifferentAccess.new(YAML.load_file(PERIODS_FILE))

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
      periods_above_user_contributions.map do |period, percents|
        employee_percentage = percents[:employee_percent] || employee_percent
        employer_percentage = percents[:employer_percent] || employer_percent

        Wpcc::PeriodContributionCalculator.new(
          name: period.to_s,
          employee_percent: employee_percentage,
          employer_percent: employer_percentage,
          eligible_salary: eligible_salary,
          salary_frequency: salary_frequency,
          tax_relief_percent: percents[:tax_relief_percent]
        ).contribution
      end
    end

    private

    def periods_above_user_contributions
      periods.select do |_, percents|
        current_period?(percents) ||
          contribution_below_legal_minimum?(percents)
      end
    end

    def current_period?(percents)
      percents[:employee_percent].blank?
    end

    def contribution_below_legal_minimum?(percents)
      employee_percent < percents[:employee_percent] ||
        employer_percent < percents[:employer_percent]
    end

    def periods
      PERIODS
    end
  end
end
