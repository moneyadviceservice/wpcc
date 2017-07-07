module Wpcc
  class YourResultsController < EngineController
    def index
      @schedule = present(
        ContributionsCalendar.new(contributions_params).schedule
      )
    end

    private

    def contributions_params
      {
        eligible_salary: session[:eligible_salary].to_i,
        employee_percent: session[:employee_percent].to_i,
        employer_percent: session[:employer_percent].to_i,
        salary_frequency: convert_salary_frequency(session[:salary_frequency])
      }
    end

    def convert_salary_frequency(salary_frequency)
      Wpcc::SalaryFrequencyConverter.convert(salary_frequency)
    end

    def present(your_results)
      your_results.each do |period| 
        present_period_contribution(period) 
      end
    end

    def present_period_contribution(period_contribution)
      Wpcc::PeriodContributionPresenter.new(
        period_contribution: period_contribution,
        translator: method(:translate)
      )
    end
  end
end
