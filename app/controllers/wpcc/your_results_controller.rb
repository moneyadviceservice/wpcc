module Wpcc
  class YourResultsController < EngineController
    def index
      @schedule = ContributionsCalendar.new(contributions_params).schedule
    end

    private

    def contributions_params
      {
        eligible_salary: session[:eligible_salary],
        employee_percent: session[:employee_percent],
        employer_percent: session[:employer_percent],
        salary_frequency: session[:salary_frequency]
      }
    end
  end
end
