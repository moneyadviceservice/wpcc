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
        let(:your_details_form) { Wpcc::YourDetailsForm.new(session) }
        let(:session) do
          {
            'age' => 34,
            'gender' => 'female',
            'salary' => 34_125,
            'salary_frequency' => 'year',
            'contribution_preference' => 'minimum'
          }
        end

        it 'instantiates a YourDetailsForm object with the session details' do
          expect(Wpcc::YourDetailsForm)
            .to receive(:new)
            .with(session)
            .and_return(your_details_form)

          get :new, nil, session
        end
      end
    end

    describe '#create' do
      context 'success' do
        after { Timecop.return }

        let(:your_details_form) { Wpcc::YourDetailsForm.new(nil_session) }
        let(:nil_session) do
          {
            'age' => nil,
            'gender' => nil,
            'salary' => nil,
            'salary_frequency' => nil,
            'contribution_preference' => nil
          }
        end

        it 'stores the form input in a session for 30 minutes' do
          post_create

          expect(session['age']).to eq('34')
          expect(session['gender']).to eq('female')
          expect(session['salary']).to eq('30000')
          expect(session['salary_frequency']).to eq('month')
          expect(session['contribution_preference']).to eq('full')

          Timecop.travel(30.minutes.from_now) do
            expect(Wpcc::YourDetailsForm)
              .to receive(:new)
              .with(nil_session)
              .and_return(your_details_form)

            get :new, nil, nil_session
          end
        end

        it 'redirects to step2 - your contributions section' do
          post_create

          expect(response).to redirect_to new_your_contribution_path
        end
      end

      context 'failure' do
        it 'renders the new page for your details' do
          post_create('error')

          expect(response).to render_template(:new)
        end
      end
    end

    def post_create(gender = 'female')
      post :create,
           locale: 'en',
           your_details_form: {
             age: 34,
             gender: gender,
             salary: 30_000,
             salary_frequency: 'month',
             contribution_preference: 'full'
           }
    end
  end
end
