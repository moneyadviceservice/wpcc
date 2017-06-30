module Wpcc
  describe YourContributionsController do
    routes { Wpcc::Engine.routes }

    describe '#new' do
      let(:salary) { 30_000 }
      let(:contribution_preference) { 'minimum' }
      let(:eligible_salary) { 24_124 }
      let(:your_contribution) do
        double(Wpcc::YourContribution,
               eligible_salary: eligible_salary,
               employee_percent: 1,
               employer_percent: 1)
      end
      let(:your_contributions_form) do
        double(Wpcc::YourContributionsForm,
               employee_percent: 1,
               employer_percent: 1)
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
        expect(Wpcc::CalculatorDelegator)
          .to receive(:delegate)
          .with(salary, contribution_preference)
          .and_return(your_contribution)

        expect(your_contribution).to receive(:eligible_salary)

        get_new('en')
      end

      it 'instantiates the YourContributions form' do
        expect(Wpcc::YourContributionsForm)
          .to receive(:new)
          .with(employee_percent: 1, employer_percent: 1)

        get_new('en')
      end

    describe '#create' do
      context 'success' do
        it 'stores the form input in a session' do
          post_create

          expect(session['employee_percent']).to eq('1')
          expect(session['employer_percent']).to eq('1')
        end

        it 'redirects to Step 3: Your results section' do
          post_create
          expect(response).to redirect_to your_results_path
        end
      end

      context 'failure' do
        it 'redirects to Step 2: Your contributions page' do
          post_create('en', 101)

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
          contribution_preference: contribution_preference
    end

    def post_create(locale = 'en', employee_percent = 1)
      post :create,
           locale: locale,
           your_contributions_form: {
             employee_percent: employee_percent,
             employer_percent: 1
           }
    end
  end
end
