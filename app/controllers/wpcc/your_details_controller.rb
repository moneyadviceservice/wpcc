module Wpcc
  class YourDetailsController < EngineController
    protect_from_forgery

    def new
      session_details if session?
      @your_details_form = present(Wpcc::YourDetailsForm.new)
    end

    def create
      @your_details_form = YourDetailsForm.new(your_details_form_params)
      if @your_details_form.valid?
        create_session
        redirect_to new_your_contribution_path
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
      params.require(:your_details_form).permit(:age,
                                                :salary,
                                                :gender,
                                                :salary_frequency,
                                                :contribution_preference)
    end

    def create_session
      your_details_form_params.each { |key, value| session[key] = value }
    end

    def session?
      session[:age] && session[:gender] && session[:salary] &&
        session[:salary_frequency] && session[:contribution_preference]
    end

    def session_details
      @age = session[:age]
      @gender = session[:gender].downcase
      @salary = session[:salary]
      @salary_frequency = session[:salary_frequency]
      @contribution_preference = session[:contribution_preference]
    end
  end
end
