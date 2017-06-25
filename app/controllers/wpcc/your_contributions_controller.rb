require_dependency 'wpcc/engine_controller'

module Wpcc
  class YourContributionsController < EngineController
    protect_from_forgery

    def new
      @contributions = Wpcc::ContributionsCalculator.calculate(
        session[:salary], session[:contribution_preference]
      )
      @your_contributions_form = Wpcc::YourContributionsForm.new(@contributions)
    end

    def create
    end

    private

    def your_contributions_params
      params.permit()
    end
  end
end
