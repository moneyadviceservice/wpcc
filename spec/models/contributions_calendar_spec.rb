require 'spec_helper'

describe Wpcc::ContributionsCalendar, type: :model do
  let(:contributions_calendar) do
    described_class.new(
      eligible_salary: eligible_salary,
      employee_percent: employee_percent,
      employer_percent: employer_percent,
      salary_frequency: salary_frequency
    )
  end

  describe '#schedule' do
    let(:eligible_salary) { 0 }
    let(:employee_percent) { 0 }
    let(:employer_percent) { 0 }
    let(:salary_frequency) { 0 }
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
      context 'when the employee/employer percents ARE in the yml file' do
        let(:current_period) { { some_period: { tax_relief_percent: 20 } } }

        before do
          allow(contributions_calendar)
            .to receive(:periods)
            .and_return(current_period)
        end

        it 'calls the PeriodContribution with the user provided percents' do
          expect(Wpcc::PeriodContributionCalculator)
            .to receive(:new)
            .with(name: current_period.keys.first.to_s,
                  employee_percent: employee_percent,
                  employer_percent: employer_percent,
                  eligible_salary: eligible_salary,
                  salary_frequency: salary_frequency,
                  tax_relief_percent: 20)
            .and_return(period_contribution_calculator)
          expect(period_contribution_calculator).to receive(:contribution)
          schedule
        end
      end

      context 'when NO employee/employer percents are in the yml file' do
        let(:next_period) do
          { some_period: { tax_relief_percent: 20,
                           employee_percent: 3,
                           employer_percent: 4 } }
        end

        before do
          allow(contributions_calendar)
            .to receive(:periods)
            .and_return(next_period)
        end

        it 'calls the PeriodContribution with the percents from the yml file' do
          expect(Wpcc::PeriodContributionCalculator)
            .to receive(:new)
            .with(name: next_period.keys.first.to_s,
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

      context 'when the user employee percent and employer percent is greatersor equal than the period percents' do
        let(:next_period) do
          {
            current: {
              tax_relief_percent: 20
            },
            some_period: {
              tax_relief_percent: 20,
              employee_percent: 3,
              employer_percent: 4
            }
          }
        end
        let(:employee_percent) { 3 }
        let(:employer_percent) { 4 }

        it 'ignores period percents less than user percents' do
          expect(schedule.size).to eq(1)
        end
      end
    end
  end
end
