module Wpcc
  class ContributionsCalendar
    include ActiveModel::Model
    attr_accessor :eligible_salary,
                  :salary_frequency,
                  :employee_percent,
                  :employer_percent

    def schedule
      filtered_periods.map do |period|
        Wpcc::PeriodContributionCalculator.new(
          name: period.name,
          employee_percent: period.highest_employee_percent,
          employer_percent: period.highest_employer_percent,
          eligible_salary: eligible_salary,
          salary_frequency: salary_frequency,
          tax_relief_percent: period.tax_relief_percent
        ).contribution
      end
    end

    delegate :periods, :filtered_periods, to: :period_filter

    private

    def period_filter
      @period_filter ||= PeriodFilter.new(
        user_input_employee_percent: employee_percent,
        user_input_employer_percent: employer_percent
      )
    end
  end
end
