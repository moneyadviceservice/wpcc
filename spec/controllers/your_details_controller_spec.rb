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

        let(:your_details_form) do
          assigns(:your_details_form)
        end

        before do
          get :new, nil, session
        end

        it 'sets age previously added' do
          expect(your_details_form.age).to eq(34)
        end

        it 'sets gender added' do
          expect(your_details_form.gender).to eq('female')
        end

        it 'sets salary previously added' do
          expect(your_details_form.salary).to eq(34_125)
        end

        it 'sets salary frequency previously added' do
          expect(your_details_form.salary_frequency).to eq('year')
        end

        it 'sets contribution preference previously added' do
          expect(your_details_form.contribution_preference).to eq('minimum')
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
        it 'render new page for your details' do
          post :create,
               locale: 'en',
               your_details_form: {
                 age: 34,
                 gender: 'a',
                 salary: 30_000,
                 salary_frequency: 'month',
                 contribution_preference: 'full'
               }
          expect(response).to render_template(:new)
        end
      end
    end
  end
end
