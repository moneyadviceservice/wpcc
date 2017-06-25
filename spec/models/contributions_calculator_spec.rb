require 'spec_helper'

describe Wpcc::ContributionsCalculator, type: :model do
  subject { described_class.new(salary, contribution_preference) }

  describe '#calculate' do
    context 'minimum contribution' do
      context 'salary greater than Upper Earnings Threshold' do
        let (:salary) { 50_000 }
        let (:contribution_preference) { 'minimum' }

        it 'returns eligible salary of 39,124, 1 for employee_percent and 0 for employer_percent' do
          expect(subject.calculate).to eq({
            eligible_salary: 44_124,
            employee_contribution: 1,
            employer_contribution: 1
          })
        end
      end

      context 'salary less than or equal to Upper Earnings Threshold' do
        let (:salary) { 45_000 }
        let (:contribution_preference) { 'minimum' }

        it 'returns 39,124 for eligible salary, 1 for employee and 0 for employer' do
          expect(subject.calculate).to eq({
            eligible_salary: 39_124,
            employee_contribution: 1,
            employer_contribution: 1
          })
        end
      end
    end

    context 'full contribution' do
      context 'salary less than Lower Earnings Threshold' do
        let (:salary) { 5_000 }
        let (:contribution_preference) { 'full' }

        it 'returns salary, 1 for employee and 0 for employer' do
          expect(subject.calculate).to eq({
            eligible_salary: 5_000,
            employee_contribution: 1,
            employer_contribution: 0
          })
        end
      end

      context 'salary greater than or equal to Lower Earnings Threshold' do
        let (:salary) { 5_124 }
        let (:contribution_preference) { 'full' }

        it 'returns salary minus lower limit, 1 for employee and 1 for employer' do
          expect(subject.calculate).to eq({
            eligible_salary: 5_124,
            employee_contribution: 1,
            employer_contribution: 1
          })
        end
      end
    end

  end
end
