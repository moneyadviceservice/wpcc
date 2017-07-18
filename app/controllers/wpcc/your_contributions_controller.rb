require_dependency 'wpcc/engine_controller'

module Wpcc
  class YourContributionsController < Wpcc::EngineController
    protect_from_forgery
    after_action :store_eligible_salary, :store_percentages, only: :new

    def new
      @your_contribution = Wpcc::YourContributionGenerator.new(
        session.to_hash.slice(
          'salary',
          'contribution_preference',
          'salary_frequency'
        )
      )

      @your_contributions_form = Wpcc::YourContributionsForm.new(
        contribution_percentages
      )
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
  end
end
