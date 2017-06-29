RSpec.describe Wpcc::YourResultsController do
  routes { Wpcc::Engine.routes }

  describe 'GET /' do
    let(:contributions_calendar) { double('ContributionsCalendar') }
    let(:session) do
      {
        eligible_salary: 12_124,
        employee_percent: 1,
        employer_percent: 1,
        salary_frequency: 12
      }
    end

    it 'assigns contribution calendar schedule' do
      expect(Wpcc::ContributionsCalendar)
        .to receive(:new)
        .with(session)
        .and_return(contributions_calendar)
      expect(contributions_calendar).to receive(:schedule)
      get :index, {}, session
    end
  end
end
