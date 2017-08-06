module Wpcc
  class YourResultsController < EngineController
    def index
      @schedule = Wpcc::Presenter.new(schedule, view_context: view_context)
      @message_presenter = message_presenter
    end

    private

    def schedule
      present(
        Wpcc::ContributionsCalendar.new(contributions_params).schedule
      )
    end

    def contributions_params
      {
        eligible_salary: session[:eligible_salary].to_i,
        employee_percent: session[:employee_percent].to_i,
        employer_percent: session[:employer_percent].to_i,
        salary_frequency: convert_salary_frequency(salary_frequency)
      }
    end

    def salary_frequency
      if params[:salary_frequency]
        @salary_frequency = params[:salary_frequency]
      else
        @salary_frequency = default_salary_frequency[session[:salary_frequency]]
      end
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

    def default_salary_frequency
      Hash[
        Wpcc::YourDetailsForm::SALARY_FREQUENCIES.map do |elem|
          [elem, elem == 'year' ? 'month' : elem]
        end
      ]
    end
  end
end
