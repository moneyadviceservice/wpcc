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
      periods.reject do |legal_period|
        legal_period.below_user_contributions?(self)
      end
    end

    def periods
      PERIODS.map do |period, percents|
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
  end
end
