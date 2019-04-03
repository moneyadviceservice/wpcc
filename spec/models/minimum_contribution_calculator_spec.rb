require 'spec_helper'

describe Wpcc::MinimumContributionCalculator, type: :model do
  subject do
    described_class.new(salary_per_year, contribution_preference)
  end

  let(:contribution_preference) { 'minimum' }
  let(:salary_per_year) { 10_000 }

  describe '#eligible_salary' do
    context 'yearly salary greater than Upper Earnings Threshold' do
      let(:salary_per_year) { 51_000 }

      it 'returns the upper threshold minus the lower threshold' do
        expect(subject.eligible_salary).to eq(43_864)
      end
    end
    context 'yearly salary less than or equal to Upper Earnings Threshold' do
      let(:salary_per_year) { 45_000 }

      it 'returns yearly salary minus the lower threshold' do
        expect(subject.eligible_salary).to eq(38_864)
      end
    end
  end

  describe '#employee_percent' do
    it 'returns 5' do
      expect(subject.employee_percent).to eq(5)
    end
  end

  describe '#employer_percent' do
    it 'returns 3' do
      expect(subject.employer_percent).to eq(3)
    end
  end
end
