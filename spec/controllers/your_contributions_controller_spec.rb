module Wpcc
  describe YourContributionsController do
    routes { Wpcc::Engine.routes }

    describe '#new' do
      let(:salary) { 30_000 }
      let(:contribution_preference) { 'minimum' }
      let(:your_contributions_form) do
        double(Wpcc::YourContributionsForm,
               employee_percent: 1,
               employer_percent: 1)
      end

      context 'english' do
        it 'renders the start view for english' do
          get :new,
              nil,
              locale: 'en',
              salary: salary,
              contribution_preference: contribution_preference

          expect(response).to be_success
        end
      end

      context 'welsh' do
        it 'renders the start view for welsh' do
          get :new,
              nil,
              locale: 'cy',
              salary: salary,
              contribution_preference: contribution_preference

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
        get :new,
            nil,
            salary: salary,
            contribution_preference: contribution_preference

        expect(response).to render_template :new
      end

      it 'instantiates the YourContributions form' do
        expect(Wpcc::CalculatorDelegator)
          .to receive(:delegate)
          .with(salary, contribution_preference)
          .and_return(your_contributions_form)
        expect(Wpcc::YourContributionsForm)
          .to receive(:new)
          .with(employee_percent: 1, employer_percent: 1)

        get :new,
            nil,
            salary: salary,
            contribution_preference: contribution_preference

        expect(response).to render_template(:new)
      end
    end
  end
end
