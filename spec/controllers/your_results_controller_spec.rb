RSpec.describe Wpcc::YourResultsController do
  routes { Wpcc::Engine.routes }

  let(:contributions_calendar) { double('ContributionsCalendar') }
  let(:schedule) { period_contribution }
  let(:period_contribution) { double(Wpcc::PeriodContribution) }
  let(:period_contribution_presenter) do
    double(Wpcc::PeriodContributionPresenter)
  end
  let(:message_presenter) { double(Wpcc::MessagePresenter) }
  let(:salary_message) { double(Wpcc::SalaryMessage) }
  let(:salary_frequency) { double(Wpcc::SalaryFrequency) }
  let(:period) { double(Wpcc::Period) }
  let(:salary_per_year) { double(Wpcc::SalaryPerYear) }

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
    it 'returns a PeriodContributionPresenter' do
      request.session[:salary] = 75
      request.session[:salary_frequency] = 'week'

      expect(Wpcc::SalaryPerYear)
        .to receive(:new)
        .with(
          salary: 75,
          salary_frequency: 'week'
        )
        .and_return(salary_per_year)

      expect(salary_per_year).to receive(:convert)

      expect(Wpcc::ContributionsCalendar)
        .to receive(:new)
        .and_return(contributions_calendar)

      expect(contributions_calendar)
        .to receive(:schedule)
        .and_return(schedule)

      expect(Wpcc::PeriodContributionPresenter)
        .to receive(:new)
        .exactly(1)
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
        .with(
          locale: nil,
          params_salary_frequency: nil,
          session_salary_frequency: 'week'
        )
        .and_return(salary_frequency)

      @controller.send(:salary_frequency)
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
          salary_frequency: 'week',
          employee_percent: nil
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
