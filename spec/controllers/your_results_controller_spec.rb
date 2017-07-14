RSpec.describe Wpcc::YourResultsController do
  routes { Wpcc::Engine.routes }

  describe 'GET /' do
    let(:contributions_calendar) { double('ContributionsCalendar') }
    let(:session) do
      {
        eligible_salary: 12_124,
        employee_percent: 1,
        employer_percent: 1,
        salary_frequency: 'week'
      }
    end
    let(:schedule) { [period_contribution, period_contribution] }
    let(:period_contribution) { double(Wpcc::PeriodContribution) }
    let(:presenter) { double(Wpcc::PeriodContributionPresenter) }

    it 'builds a contribution calendar schedule using the session salary_frequency' do
      args = session.merge(salary_frequency: 52)
      expect(Wpcc::ContributionsCalendar)
        .to receive(:new)
        .with(args)
        .and_return(contributions_calendar)
      expect(contributions_calendar)
        .to receive(:schedule)
        .and_return(schedule)

      get :index, {}, session
    end

    it 'converts salary_frequency from a string to an integer' do
      expect(Wpcc::SalaryFrequencyConverter)
        .to receive(:convert)
        .with('week')
        .and_return(52)

      get :index, {}, session
    end

    it 'wraps each PeriodContribution in a presenter' do
      expect(Wpcc::PeriodContributionPresenter)
        .to receive(:new)
        .exactly(3)
        .times
        .and_return(presenter)
      expect(assigns(:schedule))

      get :index, {}, session
    end

    it 'assigns the results to a schedule variable' do
      expect(assigns(:schedule))

      get :index, {}, session
    end
  end

  describe 'POST /' do
    it 'builds a contribution calendar schedule using the salary_frequency from the form' do
      expect(Wpcc::SalaryFrequencyConverter)
        .to receive(:convert)
        .with('month')
        .and_return(12)

      post :index, {salary_frequency: 'month'}, session
    end
  end
end
