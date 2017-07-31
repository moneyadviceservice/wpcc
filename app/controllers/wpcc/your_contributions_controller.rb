require_dependency 'wpcc/engine_controller'

module Wpcc
  class YourContributionsController < Wpcc::EngineController
    protect_from_forgery
    after_action :store_eligible_salary, :store_percentages, only: :new

    def new
      salary_per_year = SalaryPerYear.new(
        salary: session[:salary],
        salary_frequency: session[:salary_frequency]
      ).convert

      @your_contribution = Wpcc::YourContributionGenerator.new(
        contribution_preference: session[:contribution_preference],
        salary_per_year: salary_per_year
      )

      @your_contributions_form = Wpcc::YourContributionsForm.new(
        contribution_percentages
      )

      @message_presenter = message_presenter
    end

    def create
      @your_contributions_form = Wpcc::YourContributionsForm.new(
        your_contributions_params
      )

      if @your_contributions_form.valid?
        amend_session
        redirect_to your_results_path
      else
        redirect_to new_your_contribution_path
      end
    end

    private

    def your_contributions_params
      params.require(:your_contributions_form)
            .permit(:employee_percent, :employer_percent)
    end

    def amend_session
      your_contributions_params.keys.each do |key|
        session[key] = params[:your_contributions_form][key]
      end
    end

    def store_eligible_salary
      session[:eligible_salary] = @your_contribution.eligible_salary
    end

    def store_percentages
      session[:employee_percent] = @your_contributions_form.employee_percent
      session[:employer_percent] = @your_contributions_form.employer_percent
    end

    def contribution_percentages
      employee_percent = session[:employee_percent] ||
                         @your_contribution.employee_percent
      employer_percent = session[:employer_percent] ||
                         @your_contribution.employer_percent

      {
        employee_percent: employee_percent,
        employer_percent: employer_percent
      }
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
        salary_frequency: session[:salary_frequency],
        text: :manually_opt_in
      )
    end
  end
end
