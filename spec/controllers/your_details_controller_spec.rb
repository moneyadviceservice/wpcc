module Wpcc
  describe YourDetailsController do
    routes { Wpcc::Engine.routes }

    describe '#new' do
      context 'english' do
        it 'renders the start view for english' do
          get :new, locale: 'en'

          expect(response).to be_success
        end
      end

      context 'welsh' do
        it 'renders the start view for welsh' do
          get :new, locale: 'cy'

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

      context 'when editing details which have previously been submitted' do
        let(:session) do
          {
            age: 34,
            gender: 'female',
            salary: 34_125,
            salary_frequency: 'year',
            contribution_preference: 'minimum'
          }
        end
        it 'assigns the details for use in the view' do
          get :new, nil, session
          expect(assigns(:age)).to eq(34)
          expect(assigns(:gender)).to eq('female')
          expect(assigns(:salary)).to eq(34_125)
          expect(assigns(:salary_frequency)).to eq('year')
          expect(assigns(:contribution_preference)).to eq('minimum')
        end
      end
    end

    describe '#create' do
      context 'success' do
        it 'stores the form input in a session' do
          post :create,
               locale: 'en',
               your_details_form: {
                 age: 34,
                 gender: 'female',
                 salary: 30_000,
                 salary_frequency: 'month',
                 contribution_preference: 'full'
               }

          expect(session['age']).to eq('34')
          expect(session['gender']).to eq('female')
          expect(session['salary']).to eq('30000')
          expect(session['salary_frequency']).to eq('month')
          expect(session['contribution_preference']).to eq('full')
        end

        it 'redirects to step2 - your contributions section' do
          post :create,
               locale: 'en',
               your_details_form: {
                 age: 34,
                 gender: 'female',
                 salary: 30_000,
                 salary_frequency: 'month',
                 contribution_preference: 'full'
               }
          expect(response).to redirect_to new_your_contribution_path
        end
      end

      context 'failure' do
        it 'redirects to the start page' do
          post :create,
               locale: 'en',
               your_details_form: {
                 age: 34,
                 gender: 'a',
                 salary: 30_000,
                 salary_frequency: 'month',
                 contribution_preference: 'full'
               }
          expect(response).to redirect_to wpcc_root_path(locale: 'en')
        end
      end
    end
  end
end
