module Wpcc
  class ContributionsCalendar
    include ActiveModel::Model
    attr_accessor :eligible_salary, :salary_frequency, :period, :annual_salary

    def schedule
      Wpcc::PeriodContributionCalculator.new(
        name: period.name,
        employee_percent: period.user_input_employee_percent,
        employer_percent: period.user_input_employer_percent,
        eligible_salary: eligible_salary,
        salary_frequency: salary_frequency,
        tax_relief_percent: period.tax_relief_percent
      ).contribution
    end
  end
end
