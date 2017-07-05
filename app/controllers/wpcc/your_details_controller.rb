module Wpcc
  class YourDetailsController < EngineController
    def new
      @your_details_form = present(Wpcc::YourDetailsForm.new)
    end

    def create
      @your_details_form = YourDetailsForm.new(your_details_form_params)

      if @your_details_form.valid?
        create_session
        redirect_to your_contributions_path
      else
        redirect_to wpcc_root_path
      end
    end

    private

    def present(your_details_form)
      Wpcc::YourDetailsFormPresenter.new(
        your_details_form: your_details_form,
        translator: method(:translate)
      )
    end

    def your_details_form_params
      params.permit(:age,
                    :salary,
                    :gender,
                    :salary_frequency,
                    :contribution_preference)
    end

    def create_session
      params[:your_details_form].keys.each do |key|
        session[key] = params[:your_details_form][key]
      end
    end
  end
end
