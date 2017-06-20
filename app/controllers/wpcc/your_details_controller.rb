require_dependency 'wpcc/engine_controller'

module Wpcc
  class YourDetailsController < EngineController
    def new; end

    def create
      @your_details_form = YourDetailsForm.new(
        params.permit(:age, :salary, :gender)
      )

      if @your_details_form.valid?
        redirect_to your_contributions_path
      else
        redirect_to wpcc_root_path
      end
    end
  end
end
