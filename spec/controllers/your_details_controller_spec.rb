module Wpcc
  describe YourDetailsController do
    routes { Wpcc::Engine.routes }
    let(:data_for_form) do
      {
        'age' => 34,
        'salary' => 30_000,
        'gender' => 'female',
        'salary_frequency' => 'month',
        'contribution_preference' => 'full'
      }
    end

    describe '#new' do
      subject { response }

      context 'supported translations' do
        it 'renders the start view for english' do
          get :new, locale: 'en'
          is_expected.to be_success
        end

        it 'renders the start view for welsh' do
          get :new, locale: 'cy'
          is_expected.to be_success
        end
      end

      context 'unsupported translation' do
        it 'throws an error for french' do
          expect do
            get :new, locale: 'fr'
          end.to raise_error ActionController::UrlGenerationError
        end
      end

      context 'editing previously submitted form' do
        it 'instantiates a YourDetailsForm object with the session details' do
          get :new, nil, data_for_form
          expect(Wpcc::YourDetailsForm)
            .to receive(:new)
            .with(data_for_form)

          get :new
        end
      end
    end

    describe '#create' do
      context 'success' do
        it 'redirects to step2 - your contributions section' do
          post_create

          expect(response).to redirect_to new_your_contribution_path
        end

        context 'salary requires manually opting in to enrolment' do
          let(:data_for_form) do
            {
              'age' => 34,
              'salary' => @salary,
              'gender' => 'female',
              'salary_frequency' => 'month',
              'contribution_preference' => 'full'
            }
          end

          it 'stores true if salary outside auto enrolment range' do
            @salary = 5_876
            post_create

            expect(session[:manually_opt_in]).to eq(true)
          end

          it 'stores true if salary is above auto enrolment range' do
            @salary = 10_001
            post_create

            expect(session[:manually_opt_in]).to eq(false)
          end

          it 'stores true if salary is below auto enrolment range' do
            @salary = 5_875
            post_create

            expect(session[:manually_opt_in]).to eq(false)
          end
        end
      end

      context 'failure' do
        it 'rerenders your details page' do
          post_create('age' => 'error')

          expect(response).to render_template(:new)
        end
      end
    end

    describe 'sessions' do
      before(:each) { post_create }
      after(:each) { Timecop.return }

      let(:data_for_form) do
        {
          'age' => '34',
          'salary' => '30000',
          'gender' => 'female',
          'salary_frequency' => 'month',
          'contribution_preference' => 'full'
        }
      end

      context 'storing the session' do
        it 'stores the form data' do
          expect(session[:age]).to eq('34')
          expect(session[:gender]).to eq('female')
          expect(session[:salary]).to eq('30000')
          expect(session[:salary_frequency]).to eq('month')
          expect(session[:contribution_preference]).to eq('full')
        end
      end

      context 'updating the session' do
        it 'expiration time updates after any action' do
          old_timestamp = session[:wpcc_expires_at]
          Timecop.travel(1.minute.from_now)
          get :new

          expect(session[:wpcc_expires_at]).to be > old_timestamp
        end
      end

      context 'session NOT expired' do
        it 'session data still exists' do
          Timecop.travel(10.minutes.from_now)

          expect(Wpcc::YourDetailsForm).to receive(:new).with(data_for_form)

          get :new
        end
      end

      context 'session expired' do
        let(:empty_data_for_form) do
          {
            'age' => nil,
            'gender' => nil,
            'salary' => nil,
            'salary_frequency' => nil,
            'contribution_preference' => nil
          }
        end

        it 'session data is reset' do
          Timecop.travel(30.minutes.from_now)

          expect(Wpcc::YourDetailsForm)
            .to receive(:new)
            .with(empty_data_for_form)

          get :new
        end
      end

      context 'recreating sessions' do
        it 'new session can be created after expiry of old' do
          Timecop.travel(35.minutes.from_now)
          get :new

          expect(session[:age]).to eq(nil)
          post_create

          expect(session[:age]).to eq('34')
          expect(session[:gender]).to eq('female')
          expect(session[:salary]).to eq('30000')
          expect(session[:salary_frequency]).to eq('month')
          expect(session[:contribution_preference]).to eq('full')
        end
      end
    end

    def post_create(form_data = data_for_form)
      post :create,
           locale: 'en',
           your_details_form: form_data
    end
  end
end
