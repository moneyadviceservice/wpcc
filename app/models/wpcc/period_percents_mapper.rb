module Wpcc
  class PeriodPercentsMapper
    include ActiveModel::Model
    extend WpccConfig
    attr_accessor :user_input_employee_percent, :user_input_employer_percent

    PERIOD = min_contribution_percentages

    def map
      PERIOD.map do |period, percents|
        Period.new(
          name: period.to_s,
          employee_percent: percents[:employee][:above_threshold],
          employer_percent: percents[:employer][:above_threshold],
          tax_relief_percent: percents[:tax_relief],
          user_input_employee_percent: user_input_employee_percent,
          user_input_employer_percent: user_input_employer_percent
        )
      end.pop
    end
  end
end
