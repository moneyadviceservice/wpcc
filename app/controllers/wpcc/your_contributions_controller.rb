require_dependency 'wpcc/engine_controller'

module Wpcc
  class YourContributionsController < EngineController
    protect_from_forgery

    def new
      @contribution = Wpcc::CalculatorDelegator.delegate(
        session[:salary].to_i, session[:contribution_preference]
      )

      add_eligible_salary

      @your_contributions_form = Wpcc::YourContributionsForm.new(
        employee_percent: @contribution.employee_percent,
        employer_percent: @contribution.employer_percent
      )
    end

    def create
      @your_contributions_form = Wpcc::YourContributionsForm.new(
        convert_params_to_integer
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

    def convert_params_to_integer
      hash = your_contributions_params
      hash.merge(hash) { |_, v| v.to_i }
    end

    def amend_session
      your_contributions_params.keys.each do |key|
        session[key] = params[:your_contributions_form][key]
      end
    end

    def store_eligible_salary
      session[:eligible_salary] = @contribution.eligible_salary
    end
  end
end
