require 'spec_helper'

describe Wpcc::FullContributionCalculator, type: :model do
  subject do 
    described_class.new(salary, contribution_preference).calculate
  end

  let(:contribution_preference) { 'full' }
  let(:salary) { 10_000 }

  describe '#calculate' do
    it 'creates a YourContribution object' do
      expect(Wpcc::YourContribution).to receive(:new)
      subject
    end

    it 'returns a YourContribution object' do
      expect(subject).to be_a Wpcc::YourContribution
    end
  end

  describe '#eligible_salary' do
    it 'returns salary' do
      expect(subject.eligible_salary).to eq(10_000)
    end
  end

  describe '#employee_percent' do
    it 'returns 1' do
      expect(subject.employee_percent).to eq(1)
    end
  end

  describe '#employer_percent' do
    context 'salary less than Lower Earnings Threshold' do
      let(:salary) { 5_000 }

      it 'returns 0' do
        expect(subject.employer_percent).to eq(0)
      end
    end
    
    context 'salary greater than or equal to Lower Earnings Threshold' do
      let(:salary) { 5_876 }

      it 'returns 1' do
        expect(subject.employer_percent).to eq(1)
      end
    end 
  end

end
