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
  let(:legal_periods) { [legal_period, legal_period] }
  let(:legal_period) { double(Wpcc::LegalPeriod) }
  let(:legal_period_presenters) do
    [legal_period_presenter, legal_period_presenter]
  end
  let(:legal_period_presenter) { double(Wpcc::LegalPeriodPresenter) }

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

    it 'returns an array of formatted LegalPeriodPresenters' do
      expect(Wpcc::PeriodFilter)
        .to receive_message_chain(:new, :legal_periods)
        .and_return(legal_periods)

      legal_periods.each do |period|
        expect(Wpcc::LegalPeriodPresenter)
          .to receive(:new)
          .with(period, view_context: view_context)
          .and_return(legal_period_presenters)
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
