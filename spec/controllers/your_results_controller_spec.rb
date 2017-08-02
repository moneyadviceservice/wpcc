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
    let(:salary_message) { double(Wpcc::SalaryMessage) }

    it 'schedules a contribution calendar with the session salary_frequency' do
      args = session.merge(salary_frequency: 52)

      expect(Wpcc::ContributionsCalendar)
        .to receive(:new)
        .with(args)
        .and_return(contributions_calendar)

      expect(contributions_calendar)
        .to receive(:period_percents)
        .once

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

    it 'creates an array of percents for each period' do
      expect(Wpcc::PeriodContributionCalculatorPresenter)
        .to receive(:new)
        .exactly(3)
        .times
        .and_return(presenter)
      expect(assigns(:period_percents))

      get :index, {}, session
    end

    it 'assigns the results to a schedule variable' do
      expect(assigns(:schedule))

      get :index, {}, session
    end

    it 'arranges for the conditional message to display' do
      expect(Wpcc::SalaryMessage)
        .to receive(:new)
        .with(
          salary: session[:salary].to_f.round(2),
          salary_frequency: session[:salary_frequency]
        )
        .and_return(salary_message)

      get :index, {}, session
    end
  end
end
