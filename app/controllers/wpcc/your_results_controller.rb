module Wpcc
  class YourResultsController < EngineController
    def index
      @schedule = ContributionsCalendar.new(contributions_params).schedule
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
  end
end
