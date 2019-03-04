module Wpcc
  class YourResultsController < EngineController
    before_action YourResultsSessionVerifier, only: :index

    def schedule
      Wpcc::PeriodContributionPresenter.new(
        calendar.schedule,
        view_context: view_context
      )
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

    def your_results_presenter
      @your_results_presenter ||= Wpcc::YourResultsPresenter.new(
        OpenStruct.new(eligible_salary: session[:eligible_salary]),
        view_context: view_context
      )
    end
    helper_method :your_results_presenter

    def message_presenter
      Wpcc::MessagePresenter.new(
        salary_message,
        view_context: view_context
      )
    end
    helper_method :message_presenter

    def period_mapper_presenter
      Wpcc::PeriodMapperPresenter.new(period_mapper, view_context: view_context)
    end
    helper_method :period_mapper_presenter

    private

    def calendar
      @calendar ||= Wpcc::ContributionsCalendar.new(contributions_params)
    end

    def period_mapper
      @period_mapper ||= PeriodMapper.new(
        user_input_employee_percent: session[:employee_percent].to_f,
        user_input_employer_percent: session[:employer_percent].to_f
      )
    end

    def contributions_params
      {
        eligible_salary: session[:eligible_salary].to_i,
        salary_frequency: salary_frequency.to_i,
        period: period_mapper.map,
        annual_salary: annual_salary
      }
    end

    def salary_message
      Wpcc::SalaryMessage.new(
        salary: session[:salary].to_f.round(2),
        salary_frequency: session[:salary_frequency],
        employee_percent: session[:employee_percent]
      )
    end

    def annual_salary
      Wpcc::SalaryPerYear.new(
        salary: session[:salary],
        salary_frequency: session[:salary_frequency]
      ).convert
    end
  end
end
