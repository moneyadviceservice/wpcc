module Wpcc
  class YourDetailsController < EngineController
    OPT_IN_SALARY_LOWER_LIMIT = 5_876
    OPT_IN_SALARY_UPPER_LIMIT = 10_000

    protect_from_forgery

    def new
      @your_details_form = present(Wpcc::YourDetailsForm.new(session_params))
    end

    def create
      @your_details_form = present(
        Wpcc::YourDetailsForm.new(your_details_form_params)
      )

      if @your_details_form.valid?
        amend_session
        redirect_to new_your_contribution_path
      else
        render 'new'
      end
    end

    private

    def present(your_details_form)
      Wpcc::YourDetailsFormPresenter.new(
        your_details_form,
        view_context: view_context
      )
    end

    def your_details_form_params
      params.require(:your_details_form).permit(:age,
                                                :salary,
                                                :gender,
                                                :salary_frequency,
                                                :contribution_preference)
    end

    def session_params
      session.to_hash.slice(
        'age',
        'salary',
        'gender',
        'salary_frequency',
        'contribution_preference'
      )
    end

    def amend_session
      your_details_form_params.each { |key, value| session[key] = value }
      session[:manually_opt_in] = manually_opt_in?
    end

    def manually_opt_in?
      salary = your_details_form_params[:salary].to_i
      salary >= OPT_IN_SALARY_LOWER_LIMIT && salary <= OPT_IN_SALARY_UPPER_LIMIT
    end
  end
end
