module Wpcc
  class YourDetailsController < EngineController
    protect_from_forgery

    before_action SessionResetter, only: :reset

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

    def reset; end

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
                                                :salary_frequency,
                                                :contribution_preference)
    end

    def session_params
      session.to_hash.slice(
        'age',
        'salary',
        'salary_frequency',
        'contribution_preference'
      )
    end

    def amend_session
      your_details_form_params.each { |key, value| session[key] = value }
    end
  end
end
