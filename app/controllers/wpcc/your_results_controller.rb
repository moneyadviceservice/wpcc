module Wpcc
  class YourResultsController < EngineController
    helper Wpcc::YourResultsPageHelper

    def index
      @schedule = present(
        Wpcc::ContributionsCalendar.new(contributions_params).schedule
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
      your_results.map do |period|
        Wpcc::PeriodContributionPresenter.new(
          period,
          view_context: view_context
        )
      end
    end
  end
end
