module Wpcc
  class PeriodFilter
    include ActiveModel::Model
    extend WpccConfig
    attr_accessor :user_input_employee_percent, :user_input_employer_percent

    PERIODS = min_contribution_percentages_by_period

    def filtered_periods
      return current_period if periods.last.should_be_filtered_out?(self)

      periods
    end

    def periods
      PERIODS.map do |period, percents|
        ::Wpcc::Period.new(
          name: period.to_s,
          employee_percent: percents[:employee][:above_threshold],
          employer_percent: percents[:employer][:above_threshold],
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
