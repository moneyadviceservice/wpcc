module Wpcc
  describe YourDetailsController do
    routes { Wpcc::Engine.routes }

    describe '#new' do
      it 'displays the form for entering contribution percentages' do
        get :new

        expect(response).to render_template(:new)
      end

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

        it 'instantiates the YourContributions form' do
          expect(Wpcc::ContributionsCalculator).to receive(:calculate)
          expect(Wpcc::YourContributionsForm).to receive(:new)
          get :new
        end

        it 'renders the your contributions form view' do
          get :new
          expect(response).to render_template :new
        end
      end
    end

    describe '#create' do
      context 'success' do
        it 'redirects to step3 - results section' do
        end
      end

      context 'failure' do
        it 'redirects to the start page' do
        end
      end
    end
  end
end
