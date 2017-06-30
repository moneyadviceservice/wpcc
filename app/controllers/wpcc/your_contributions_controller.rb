require_dependency 'wpcc/engine_controller'

module Wpcc
  class YourContributionsController < EngineController
    protect_from_forgery

    def new
      @contributions = Wpcc::ContributionsCalculator.calculate(
        30_000, 'full'
      )
      @your_contributions_form = Wpcc::YourContributionsForm.new(@contributions)
    end

    def create
    end

    private

    def your_contributions_params
      params.permit(:employee_contribution, :employer_contribution)
    end
  end
end
