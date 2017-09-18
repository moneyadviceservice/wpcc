require 'spec_helper'

describe Wpcc::ContributionsCalendar, type: :model do
  let(:contributions_calendar) do
    described_class.new(
      eligible_salary: eligible_salary,
      salary_frequency: salary_frequency,
      periods: periods
    )
  end

  let(:eligible_salary) { 0 }
  let(:salary_frequency) { 1 }

  describe '#schedule' do
    let(:periods) do
      Wpcc::PeriodFilter.new(
        user_input_employee_percent: 1,
        user_input_employer_percent: 2
      ).periods
    end
    let(:period_contribution_calculator) do
      double('PeriodContributionCalculator')
    end

    subject(:schedule) { contributions_calendar.schedule }

    it 'returns an Array of PeriodContribution objects' do
      expect(schedule).to be_an(Array)
      expect(schedule.size).to_not be_zero
      schedule.each do |period|
        expect(period).to be_a Wpcc::PeriodContribution
      end
    end

    describe 'creates PeriodContribution objects for each period' do
      let(:periods) { [next_period] }
      let(:next_period) do
        double(
          name: 'some_period',
          tax_relief_percent: 20,
          employee_percent: 3,
          employer_percent: 4
        )
      end

      it 'calls the PeriodContributionCalculator passing the percentages' do
        expect(next_period).to receive(:highest_employee_percent).and_return(3)

        expect(next_period).to receive(:required_employer_percent).and_return(4)

        expect(Wpcc::PeriodContributionCalculator)
          .to receive(:new)
          .with(name: next_period.name,
                employee_percent: 3,
                employer_percent: 4,
                eligible_salary: eligible_salary,
                salary_frequency: salary_frequency,
                tax_relief_percent: 20)
          .and_return(period_contribution_calculator)
        expect(period_contribution_calculator).to receive(:contribution)

        schedule
      end
    end
  end
end
