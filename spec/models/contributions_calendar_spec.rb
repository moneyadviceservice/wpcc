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
  let(:eligible_salary) { 0 }
  let(:employee_percent) { 0 }
  let(:employer_percent) { 0 }
  let(:salary_frequency) { 0 }

  describe '#schedule' do
    subject(:schedule) { contributions_calendar.schedule }
    
    it 'returns an Array of PeriodContribution objects' do
      expect(schedule).to be_an(Array)
      expect(schedule.size).to_not be_zero
      schedule.each do |period|
        expect(period).to be_a Wpcc::PeriodContribution
      end
    end

    context 'creates PeriodContribution objects for each period' do
      context 'when the employee/employer percents ARE in the yml file' do
        let(:current_period) { {some_period: { tax_relief_percent: 20 }} }
        before do allow(contributions_calendar)
          .to receive(:periods)
          .and_return(current_period)
        end

        it 'calls the PeriodContribution with the user provided percents' do
          expect(Wpcc::PeriodContribution)
            .to receive(:new)
            .with(eligible_salary, 
                  salary_frequency, 
                  employee_percent, 
                  employer_percent)
          subject
        end
      end

      context 'when NO employee/employer percents are in the yml file' do
        let(:next_period) do 
          { some_period: { tax_relief_percent: 20, 
                           employee_percent: 3, 
                           employer_percent: 4 
                         } 
          }
        end

        before do allow(contributions_calendar)
          .to receive(:periods)
          .and_return(next_period)
        end

        it 'calls the PeriodContribution with the percents from the yml file' do
          expect(Wpcc::PeriodContribution)
            .to receive(:new)
            .with(eligible_salary, salary_frequency, 3, 4)
          subject
        end
      end
    end

  end
end
