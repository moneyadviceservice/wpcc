require_dependency 'wpcc/engine_controller'

module Wpcc
  class YourContributionsController < EngineController
    protect_from_forgery

    def new
      @contribution = Wpcc::CalculatorDelegator.delegate(
        session[:salary].to_i, session[:contribution_preference]
      )

      @your_contributions_form = Wpcc::YourContributionsForm.new(
        employee_percent: @contribution.employee_percent,
        employer_percent: @contribution.employer_percent
      )
    end

    def create
      @your_contributions_form = Wpcc::YourContributionsForm.new(
        convert_params
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

    def convert_params
      hash = your_contributions_params
      hash.merge(hash){|k, v| v.to_i}
    end

    def amend_session
      your_contributions_params.keys.each do |key|
        session[key] = params[:your_contributions_form][key]
      end    
    end
  end
end
