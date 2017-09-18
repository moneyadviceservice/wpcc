module Wpcc
  class ContributionsCalendar
    include ActiveModel::Model
    attr_accessor :eligible_salary, :salary_frequency, :periods

    def schedule
      periods.map do |period|
        Wpcc::PeriodContributionCalculator.new(
          name: period.name,
          employee_percent: period.highest_employee_percent,
          employer_percent: period.required_employer_percent(eligible_salary),
          eligible_salary: eligible_salary,
          salary_frequency: salary_frequency,
          tax_relief_percent: period.tax_relief_percent
        ).contribution
      end
    end
  end
end
