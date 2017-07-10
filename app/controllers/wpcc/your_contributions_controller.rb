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

    private

    def your_contributions_params
      params.permit(:employee_percent, :employer_percent)
    end
  end
end
