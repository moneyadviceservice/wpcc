module Wpcc
  class ContributionsCalendar
    include ActiveModel::Model
    attr_accessor :eligible_salary,
                  :salary_frequency,
                  :employee_percent,
                  :employer_percent

    def schedule
      periods_above_user_contributions.map do |period, percents|
        if percents[:employee_percent] && employee_percent > percents[:employee_percent]
          employee_percentage = employee_percent
        else
          employee_percentage = percents[:employee_percent] || employee_percent
        end

        if percents[:employer_percent] && employer_percent > percents[:employer_percent]
          employer_percentage = employer_percent
        else
          employer_percentage = percents[:employer_percent] || employer_percent
        end

        Wpcc::PeriodContributionCalculator.new(
          name: period.to_s,
          employee_percent: employee_percentage,
          employer_percent: employer_percentage,
          eligible_salary: eligible_salary,
          salary_frequency: salary_frequency,
          tax_relief_percent: percents[:tax_relief_percent]
        ).contribution
      end
    end

    private

    def periods_above_user_contributions
      ContributionPeriods.new(
        employee_percent: employee_percent,
        employer_percent: employer_percent
      ).above_user_contributions
    end
  end
end
