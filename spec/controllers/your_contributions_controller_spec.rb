module Wpcc
  describe YourContributionsController do
    routes { Wpcc::Engine.routes }

    describe '#new' do
      let(:age) { 20 }
      let(:gender) { 'female' }
      let(:salary) { 30_000 }
      let(:contribution_preference) { 'minimum' }
      let(:eligible_salary) { 23_864 }
      let(:salary_frequency) { 'year' }
      let(:salary_message) { double(Wpcc::SalaryMessage) }

      let(:your_contribution) do
        double(
          eligible_salary: eligible_salary,
          employee_percent: 5,
          employer_percent: 3
        )
      end
      let(:your_contributions_form) do
        double(
          Wpcc::YourContributionsForm,
          employee_percent: 5,
          employer_percent: 3
        )
      end

      context 'english' do
        it 'renders the start view for english' do
          get_new

          expect(response).to be_success
        end
      end

      context 'welsh' do
        it 'renders the start view for welsh' do
          get_new('cy')

          expect(response).to be_success
        end
      end

      context 'when session has no keys' do
        it 'redirects to root page' do
          get :new, {}, {}

          expect(response)
            .to redirect_to wpcc_root_path(locale: 'en')
        end
      end

      context 'translation not supported' do
        it 'throws an error for an unsupported locale' do
          expect do
            get :new, locale: 'fr'
          end.to raise_error ActionController::UrlGenerationError
        end
      end

      it 'renders the your contributions form view' do
        get_new('en')

        expect(response).to render_template :new
      end

      it 'calculates the eligible_salary and stores it in a session' do
        get_new('en')

        expect(session[:eligible_salary]).to eq(eligible_salary)
      end

      context 'when returning to your contributions path' do
        let(:your_contributions_form) do
          assigns(:your_contributions_form)
        end

        it 'sets employee & employer percent previously added' do
          get :new,
              nil,
              employee_percent: 10,
              employer_percent: 40,
              salary: salary,
              contribution_preference: contribution_preference,
              salary_frequency: 'year',
              age: age,
              gender: gender

          expect(your_contributions_form.employee_percent).to eq(10)
          expect(your_contributions_form.employer_percent).to eq(40)
        end

        it 'arranges for the conditional message to display' do
          expect(Wpcc::SalaryMessage)
            .to receive(:new)
            .with(
              salary: salary,
              salary_frequency: salary_frequency,
              employee_percent: 10,
              text: :manually_opt_in
            )
            .and_return(salary_message)

          get :new,
              nil,
              employee_percent: 10,
              employer_percent: 40,
              salary: salary,
              contribution_preference: contribution_preference,
              salary_frequency: 'year',
              age: age,
              gender: gender
        end
      end
    end

    describe '#create' do
      context 'success' do
        it 'stores the form input in a session' do
          post_create

          expect(session['employee_percent']).to eq('5')
          expect(session['employer_percent']).to eq('3')
        end

        it 'redirects to Step 3: Your results section' do
          post_create
          expect(response).to redirect_to your_results_path
        end
      end

      context 'failure' do
        it 'redirects to Step 2: Your contributions page' do
          post_create('en', 1)

          expect(response)
            .to redirect_to new_your_contribution_path(locale: 'en')
        end
      end
    end

    def get_new(locale = 'en')
      get :new,
          nil,
          locale: locale,
          salary: salary,
          contribution_preference: contribution_preference,
          salary_frequency: salary_frequency,
          age: age,
          gender: gender
    end

    def post_create(locale = 'en', employee_percent = 5)
      post :create,
           locale: locale,
           your_contributions_form: {
             employee_percent: employee_percent,
             employer_percent: 3
           }
    end
  end
end
