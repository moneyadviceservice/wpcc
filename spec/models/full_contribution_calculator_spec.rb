require 'spec_helper'

describe Wpcc::FullContributionCalculator, type: :model do
  subject do
    described_class.new(salary_per_year, contribution_preference)
  end

  let(:contribution_preference) { 'full' }
  let(:salary_per_year) { 10_000 }

  describe '#eligible_salary' do
    it 'returns salary per year' do
      expect(subject.eligible_salary).to eq(10_000)
    end
  end

  describe '#employee_percent' do
    context 'yearly salary less than Lower Earnings Threshold' do
      let(:salary_per_year) { 5_000 }

      it 'returns 3' do
        expect(subject.employee_percent).to eq(5)
      end
    end

    context 'yearly salary greater than or equal to Lower Earnings Threshold' do
      let(:salary_per_year) { 6_032 }

      it 'returns 5' do
        expect(subject.employee_percent).to eq(5)
      end
    end
  end

  describe '#employer_percent' do
    context 'yearly salary less than Lower Earnings Threshold' do
      let(:salary_per_year) { 5_000 }

      it 'returns 0' do
        expect(subject.employer_percent).to eq(0)
      end
    end

    context 'yearly salary greater than or equal to Lower Earnings Threshold' do
      let(:salary_per_year) { 6_032 }

      it 'returns 2' do
        expect(subject.employer_percent).to eq(3)
      end
    end
  end
end
