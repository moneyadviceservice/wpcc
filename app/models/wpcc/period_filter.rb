module Wpcc
  class PeriodFilter
    include ActiveModel::Model
    attr_accessor :user_input_employee_percent, :user_input_employer_percent

    PERIODS_FILE = Wpcc::Engine.root.join(
      'config',
      'periods_legal_percents.yml'
    )
    PERIODS = HashWithIndifferentAccess.new(YAML.load_file(PERIODS_FILE))

    def filter
      filtered_periods = PERIODS.reject do |_, percents|
        period_has_legal_minimum?(percents) &&
          period_below_user_contributions?(percents)
      end

      filtered_periods.map do |period, percents|
        ::Wpcc::Period.new(
          name: period.to_s,
          employee_percent: percents[:employee],
          employer_percent: percents[:employer],
          tax_relief_percent: percents[:tax_relief],
          user_input_employee_percent: user_input_employee_percent,
          user_input_employer_percent: user_input_employer_percent
        )
      end
    end

    def period_below_user_contributions?(percents)
      percents[:employee] <= user_input_employee_percent &&
        percents[:employer] <= user_input_employer_percent
    end

    def period_has_legal_minimum?(percents)
      percents[:employee].present?
    end
  end
end
