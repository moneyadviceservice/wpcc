module Wpcc
  class LegalPeriodPercents
    include ActiveModel::Model
    attr_accessor :name,
                  :employee_percent,
                  :employer_percent,
                  :tax_relief_percent

    PERIODS_FILE = Wpcc::Engine.root.join(
      'config',
      'legal_periods_percents.yml'
    )
    PERIODS = HashWithIndifferentAccess.new(YAML.load_file(PERIODS_FILE))

    def self.all
      PERIODS.map do |period, percents|
        new(
          name: period.to_s,
          employee_percent: percents[:employee_percent],
          employer_percent: percents[:employer_percent],
          tax_relief_percent: percents[:tax_relief_percent]
        )
      end
    end

    def self.filter(user_input_employee_percent, user_input_employer_percent)
      periods = periods_above_user_contribution(
        user_input_employee_percent, user_input_employer_percent
      )
      periods.each do |legal_period_percents|
        legal_period_percents.employee_percent = Percent.choose_highest(
          legal_period_percents.employee_percent, user_input_employee_percent
        )
        legal_period_percents.employer_percent = Percent.choose_highest(
          legal_period_percents.employer_percent, user_input_employer_percent
        )
      end
    end

    def self.periods_above_user_contribution(user_input_employee_percent,
                                             user_input_employer_percent)
      all.reject do |legal_period_percents|
        legal_period_percents.below_user_contributions?(
          user_input_employee_percent,
          user_input_employer_percent
        )
      end
    end

    def below_user_contributions?(user_input_employee_percent,
                                  user_input_employer_percent)
      period_has_legal_minimum? &&
        @employee_percent <= user_input_employee_percent &&
        @employer_percent <= user_input_employer_percent
    end

    private

    def period_has_legal_minimum?
      @employee_percent.present?
    end
  end
end
