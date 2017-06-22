module Wpcc
  describe YourDetailsController do
    routes { Wpcc::Engine.routes }

    describe '#new' do
      it 'renders the start view for english' do
        get :new, locale: 'en'

        expect(response).to be_success
      end

      it 'renders the start view for welsh' do
        get :new, locale: 'cy'

        expect(response).to be_success
      end

      it 'throws an error for an unsupported locale' do
        expect do
          get :new, locale: 'fr'
        end.to raise_error ActionController::UrlGenerationError
      end
    end

    describe '#create' do
      context 'success' do
        it 'redirects to step2 - your contributions section' do
          post :create,
               locale: 'en',
               age: 34,
               gender: 'f',
               salary: 30_000

          expect(response).to redirect_to your_contributions_path
        end
      end

      context 'failure' do
        it 'redirects to the start page' do
          post :create,
               locale: 'en',
               age: 34,
               gender: 'a',

          expect(response).to redirect_to wpcc_root_path(locale: 'en')
        end
      end
    end
  end
end
