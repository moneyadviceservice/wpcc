module Wpcc
  class YourResultsController < EngineController
    before_action YourResultsSessionVerifier, only: :index

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
        locale: params[:locale],
        params_salary_frequency: params[:salary_frequency],
        session_salary_frequency: session[:salary_frequency]
      )
    end
    helper_method :salary_frequency

    def your_contributions_presenter
      @your_contributions_presenter ||= Wpcc::YourContributionPresenter.new(
        OpenStruct.new(eligible_salary: session[:eligible_salary]),
        view_context: view_context
      )
    end
    helper_method :your_contributions_presenter

    def period_legal_percents
      period_filter.periods.map do |period|
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

    def period_filter_presenter
      Wpcc::PeriodFilterPresenter.new(period_filter, view_context: view_context)
    end
    helper_method :period_filter_presenter

    private

    def calendar
      @calendar ||= Wpcc::ContributionsCalendar.new(contributions_params)
    end

    def period_filter
      @period_filter ||= PeriodFilter.new(
        user_input_employee_percent: session[:employee_percent].to_f,
        user_input_employer_percent: session[:employer_percent].to_f
      )
    end

    def contributions_params
      {
        eligible_salary: session[:eligible_salary].to_i,
        salary_frequency: salary_frequency.to_i,
        periods: period_filter.filtered_periods
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
