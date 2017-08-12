module Wpcc
  class YourResultsController < EngineController
    def schedule
      calendar.schedule.map do |period_contribution|
        Wpcc::PeriodContributionPresenter.new(
          period_contribution,
          view_context: view_context
        )
      end
    end
    helper_method :schedule

    def salary_frequency
      @salary_frequency ||= SalaryFrequency.new(
        params_salary_frequency: params[:salary_frequency],
        session_salary_frequency: session[:salary_frequency]
      )
    end
    helper_method :salary_frequency

    def period_legal_percents
      calendar.periods.map do |period|
        Wpcc::PeriodPresenter.new(
          period,
          view_context: view_context
        )
      end
    end
    helper_method :period_legal_percents

    def message_presenter
      Wpcc::MessagePresenter.new(
        salary_message,
        view_context: view_context
      )
    end
    helper_method :message_presenter

    private

    def calendar
      @calendar ||= Wpcc::ContributionsCalendar.new(contributions_params)
    end

    def contributions_params
      {
        eligible_salary: session[:eligible_salary].to_i,
        employee_percent: session[:employee_percent].to_i,
        employer_percent: session[:employer_percent].to_i,
        salary_frequency: salary_frequency.to_i
      }
    end

    def salary_message
      Wpcc::SalaryMessage.new(
        salary: session[:salary].to_f.round(2),
        salary_frequency: session[:salary_frequency]
      )
    end
  end
end
