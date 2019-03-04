require 'spec_helper'

describe Wpcc::ContributionsCalendar, type: :model do
  let(:contributions_calendar) do
    described_class.new(
      eligible_salary: eligible_salary,
      salary_frequency: salary_frequency,
      period: period,
      annual_salary: salary
    )
  end

  let(:eligible_salary) { 0 }
  let(:salary_frequency) { 1 }
  let(:salary) { 11_000 }

  describe '#schedule' do
    let(:period) do
      Wpcc::PeriodMapper.new(
        user_input_employee_percent: 1,
        user_input_employer_percent: 2
      ).map
    end
    let(:period_contribution_calculator) do
      double('PeriodContributionCalculator')
    end

    subject(:schedule) { contributions_calendar.schedule }

    it 'returns a PeriodContribution object' do
      expect(schedule).to be_an(Wpcc::PeriodContribution)
    end

    it 'Logs details for the period' do
      expect(Rails.logger).to receive(:info).with(
        <<-TEST_MSG.strip_heredoc
          Calculating period current with:
          Eligible Salary: 0
          Employee percent: 5
          Employer percent: 3
          Tax relief percent: 20
        TEST_MSG
      )
      subject
    end
  end
end
