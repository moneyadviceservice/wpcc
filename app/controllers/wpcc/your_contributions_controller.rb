require_dependency 'wpcc/engine_controller'

module Wpcc
  class YourContributionsController < EngineController
    protect_from_forgery

    def new
      @contributions = Wpcc::CalculatorDelegator.delegate(
        30_000, 'full'
      )
      @your_contributions_form = Wpcc::YourContributionsForm.new
    end

    def create
      @your_contributions_form = Wpcc::YourContributionsForm.new(your_contributions_params)
      if @your_contributions_form.valid?
        redirect_to your_results_path
      else
        redirect_to new_your_contributions_path
      end
    end

    private

    def your_contributions_params
      params.permit(:employee_contribution, :employer_contribution)
    end
  end
end
