module Wpcc
  class ContributionsCalendar
    include ActiveModel::Model
    attr_accessor :eligible_salary,
                  :salary_frequency,
                  :employee_percent,
                  :employer_percent

    def schedule
      period_percents.map(&:contribution)
    end

    def period_percents
      periods.map { |period| percents_for(period) }
    end

    private

    def periods
      PeriodFilter.new(
        user_input_employee_percent: employee_percent,
        user_input_employer_percent: employer_percent
      ).filter
    end

    def percents_for(period)
      Wpcc::PeriodContributionCalculator.new(
        name: period.name,
        employee_percent: period.employee_percent,
        employer_percent: period.employer_percent,
        eligible_salary: eligible_salary,
        salary_frequency: salary_frequency,
        tax_relief_percent: period.tax_relief_percent
      )
    end
  end
end
