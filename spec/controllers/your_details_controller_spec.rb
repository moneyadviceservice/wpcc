module Wpcc
  describe YourDetailsController do
    routes { Wpcc::Engine.routes }

    let(:session) do
      {
        'age' => 34,
        'gender' => 'female',
        'salary' => 34_125,
        'salary_frequency' => 'year',
        'contribution_preference' => 'minimum'
      }
    end

    let(:nil_session) do
      {
        'age' => nil,
        'gender' => nil,
        'salary' => nil,
        'salary_frequency' => nil,
        'contribution_preference' => nil
      }
    end

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

        it 'stores the form input in a session for 30 minutes' do
          post_create

          expect(session['age']).to eq(34)
          expect(session['gender']).to eq('female')
          expect(session['salary']).to eq(34_125)
          expect(session['salary_frequency']).to eq('year')
          expect(session['contribution_preference']).to eq('minimum')

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

    describe 'sessions' do
      after { Timecop.return }

      it "'wpcc_expires_at' key should always be updated" do
        session[:wpcc_expires_at] = 5.minutes.ago
        get :new, nil, session

        expect(session[:wpcc_expires_at]).to be > 5.minutes.ago
      end

      context 'session has expired' do
        it 'should reset the wpcc specific session data to nil' do
          session[:wpcc_expires_at] = Time.current
          Timecop.travel(Time.current + 30.minutes)
          get :new, nil, session

          expect(session[:age]).to eq nil
          expect(session[:gender]).to eq nil
          expect(session[:salary]).to eq nil
          expect(session[:salary_frequency]).to eq nil
          expect(session[:contribution_preference]).to eq nil
        end
      end

      context 'session has NOT expired' do
        it 'should NOT reset the wpcc specific data to nil' do
          session[:wpcc_expires_at] = Time.current - 5.minutes
          get :new, nil, session

          expect(session['age']).to eq 34
          expect(session['gender']).to eq 'female'
          expect(session['salary']).to eq 34_125
          expect(session['salary_frequency']).to eq 'year'
          expect(session['contribution_preference']).to eq 'minimum'
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
