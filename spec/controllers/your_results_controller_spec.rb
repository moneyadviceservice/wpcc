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
    let(:salary_frequency) { double(Wpcc::SalaryFrequency) }

    it 'schedules a contribution calendar with the session salary_frequency' do
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
      expect(Wpcc::SalaryFrequency)
        .to receive(:new)
        .with(params_salary_frequency: nil, session_salary_frequency: 'week')
        .and_return(salary_frequency)

      expect(salary_frequency)
        .to receive(:to_i)
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
