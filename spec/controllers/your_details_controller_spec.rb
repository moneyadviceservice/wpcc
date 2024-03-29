module Wpcc
  describe YourDetailsController do
    routes { Wpcc::Engine.routes }
    let(:data_for_form) do
      {
        'age' => 34,
        'salary' => 30_000,
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
           locale: 'en',
           your_details_form: form_data
    end
  end
end
