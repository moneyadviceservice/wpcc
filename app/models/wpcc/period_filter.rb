module Wpcc
  class PeriodFilter
    include ActiveModel::Model
    attr_accessor :user_input_employee_percent, :user_input_employer_percent

    PERIODS = ::Wpcc::ConfigLoader.load('periods_legal_percents')

    def filtered_periods
      return current_period if periods.last.should_be_filtered_out?(self)

      periods
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

    private

    def current_period
      [periods.first]
    end
  end
end
