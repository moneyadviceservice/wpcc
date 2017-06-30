require_dependency 'wpcc/engine_controller'

module Wpcc
  class YourDetailsController < EngineController
    def new; end

    def create
      @your_details_form = YourDetailsForm.new(your_details_form_params)

      if @your_details_form.valid?
        redirect_to your_contributions_path
      else
        redirect_to wpcc_root_path
      end
    end

    private

    def your_details_form_params
      params.permit(:age, :gender, :salary, :salary_frequency, :contribution)
    end
  end
end
