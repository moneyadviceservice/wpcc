RSpec.describe Wpcc::YourResultsController do
  routes { Wpcc::Engine.routes }

  let(:contributions_calendar) { double('ContributionsCalendar') }
  let(:schedule) { [period_contribution, period_contribution] }
  let(:period_contribution) { double(Wpcc::PeriodContribution) }
  let(:period_contribution_presenter) do
    double(Wpcc::PeriodContributionPresenter)
  end
  let(:message_presenter) { double(Wpcc::MessagePresenter) }
  let(:salary_message) { double(Wpcc::SalaryMessage) }
  let(:salary_frequency) { double(Wpcc::SalaryFrequency) }
  let(:periods) { [period, period] }
  let(:period) { double(Wpcc::Period) }
  let(:period_presenters) { [period_presenter, period_presenter] }
  let(:period_presenter) { double(Wpcc::PeriodPresenter) }

  describe 'GET /your_results' do
    context 'when session has no keys' do
      it 'redirects to root page' do
        get :index, {}, {}

        expect(response)
          .to redirect_to wpcc_root_path(locale: 'en')
      end
    end
  end

  describe '#schedule' do
    it 'returns an array of formatted PeriodContributions' do
      expect(Wpcc::ContributionsCalendar)
        .to receive(:new)
        .and_return(contributions_calendar)

      expect(contributions_calendar)
        .to receive(:schedule)
        .and_return(schedule)

      expect(Wpcc::PeriodContributionPresenter)
        .to receive(:new)
        .exactly(2)
        .times
        .and_return(period_contribution_presenter)

      @controller.send(:schedule)
    end
  end

  describe '#salary_frequency' do
    it 'converts salary_frequency from a string to an integer' do
      request.session[:salary_frequency] = 'week'
      expect(Wpcc::SalaryFrequency)
        .to receive(:new)
        .with(params_salary_frequency: nil, session_salary_frequency: 'week')
        .and_return(salary_frequency)

      @controller.send(:salary_frequency)
    end
  end

  describe '#period_legal_percents' do
    before do
      allow(@controller).to receive(:view_context).and_return(view_context)
    end

    let(:view_context) { double(:view_context) }

    it 'returns an array of formatted PeriodPresenters' do
      expect(Wpcc::PeriodFilter)
        .to receive_message_chain(:new, :periods)
        .and_return(periods)

      periods.each do |period|
        expect(Wpcc::PeriodPresenter)
          .to receive(:new)
          .with(period, view_context: view_context)
          .and_return(period_presenters)
      end

      @controller.send(:period_legal_percents)
    end
  end

  describe '#message_presenter' do
    before do
      allow(@controller).to receive(:view_context).and_return(view_context)
    end

    let(:view_context) { double(:view_context) }

    it 'returns a SalaryMessage formatted for use in the view' do
      request.session[:salary] = 25_000
      request.session[:salary_frequency] = 'week'

      expect(Wpcc::SalaryMessage)
        .to receive(:new)
        .with(
          salary: 25_000.00,
          salary_frequency: 'week'
        )
        .and_return(salary_message)

      expect(Wpcc::MessagePresenter)
        .to receive(:new)
        .with(salary_message, view_context: view_context)
        .and_return(message_presenter)

      @controller.send(:message_presenter)
    end
  end
end
