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
          get :new, params: { locale: 'en' }
          is_expected.to be_success
        end

        it 'renders the start view for welsh' do
          get :new, params: { locale: 'cy' }
          is_expected.to be_success
        end
      end

      context 'unsupported translation' do
        it 'throws an error for french' do
          expect do
            get :new, params: { locale: 'fr' }
          end.to raise_error I18n::InvalidLocale
        end
      end

      context 'editing previously submitted form' do
        it 'instantiates a YourDetailsForm object with the session details' do
          get :new, session: data_for_form
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
      end

      context 'failure' do
        it 'rerenders your details page' do
          post_create('age' => 'error')

          expect(response).to render_template(:new)
        end
      end
    end

    def post_create(form_data = data_for_form)
      post :create,
           params: {
             locale: 'en',
             your_details_form: form_data
           }
    end
  end
end
