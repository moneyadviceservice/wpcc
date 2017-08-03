RSpec.describe Wpcc::YourResultsController do
  routes { Wpcc::Engine.routes }

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
  let(:period_percents) { [pcc, pcc] }
  let(:pcc) { double(Wpcc::PeriodContributionCalculator) }
  let(:pc_presenter) { double(Wpcc::PeriodContributionPresenter) }
  let(:message_presenter) { double(Wpcc::MessagePresenter) }
  let(:salary_message) { double(Wpcc::SalaryMessage) }
  let(:salary_frequency) { double(Wpcc::SalaryFrequency) }

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
        .and_return(pc_presenter)

      @controller.send(:schedule)
    end
  end

  describe '#salary_frequency' do
    it 'converts salary_frequency from a string to an integer' do
      expect(Wpcc::SalaryFrequency)
        .to receive(:new)
        .with(params_salary_frequency: nil, session_salary_frequency: 'week')
        .and_return(salary_frequency)

        expect(salary_frequency)
          .to receive(:to_i)
          .and_return(52)

    end
  end

  describe '#period_legal_percents' do
    it 'returns an array of formatted PeriodContributionCalculators' do
      expect(Wpcc::ContributionsCalendar)
        .to receive(:new)
        .and_return(contributions_calendar)

    # @controller.params = ActionController::Parameters.new({ 
    #   salary_frequency: nil 
    # })
    @controller.send(:salary_frequency)
    end
  end

  describe '#message_presenter' do
    it 'returns a SalaryMessage formatted for use in the view' do
      expect(Wpcc::SalaryFrequencyConverter)
        .to receive(:convert)
        .with('week')
        .and_return(52)

      expect(Wpcc::SalaryMessage)
        .to receive(:new)
        .with(
          salary: session[:eligible_salary].to_f.round(2),
          salary_frequency: session[:salary_frequency]
        )
        .and_return(salary_message)

      expect(Wpcc::MessagePresenter)
        .to receive(:new)
        .with(salary_message)
        .and_return(message_presenter)

      @controller.send(:message_presenter)
    end
  end
end
