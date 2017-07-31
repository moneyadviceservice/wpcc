module Wpcc
  class YourResultsController < EngineController
    def index
      @schedule = Wpcc::Presenter.new(schedule, view_context: view_context)
      @message_presenter = message_presenter
      @period_percents = present_period_contribution_calculations(
        period_percents
      )
    end

    def salary_frequency
      @salary_frequency ||= SalaryFrequency.new(
        params_salary_frequency: params[:salary_frequency],
        session_salary_frequency: session[:salary_frequency]
      )
    end
    helper_method :salary_frequency

    private

    def schedule
      present_period_contributions(calendar.schedule)
    end

    def period_percents
      calendar.period_percents
    end

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

    def salary_frequency
      @salary_frequency =
        params[:salary_frequency] || session[:salary_frequency]
    end

    def present_period_contributions(your_results)
      your_results.map do |period_contribution|
        Wpcc::PeriodContributionPresenter.new(
          period_contribution,
          view_context: view_context
        )
      end
    end

    def present_period_contribution_calculations(period_percents)
      period_percents.map do |period_percent|
        Wpcc::PeriodContributionCalculatorPresenter.new(
          period_percent,
          view_context: view_context
        )
      end
    end

    def message_presenter
      Wpcc::MessagePresenter.new(
        salary_message,
        view_context: view_context
      )
    end

    def salary_message
      Wpcc::SalaryMessage.new(
        salary: session[:salary].to_f.round(2),
        salary_frequency: session[:salary_frequency]
      )
    end
  end
end
