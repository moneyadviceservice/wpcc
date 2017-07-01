require 'spec_helper'

describe Wpcc::FullContributionCalculator, type: :model do
  subject do 
    described_class.new(salary, contribution_preference).calculate
  end

  describe '#calculate' do
    let(:contribution_preference) { 'full' }

    context 'salary less than Lower Earnings Threshold' do
      let(:salary) { 5_000 }

      it 'returns eligible salary equal to salary' do
        expect(subject.eligible_salary).to eq(salary)
      end

      it 'returns employee_percent of 1' do
        expect(subject.employee_percent).to eq(1)
      end

      it 'returns employer_percent of 0' do
        expect(subject.employer_percent).to eq(0)
      end
    end
    
    context 'salary greater than or equal to Lower Earnings Threshold' do
      let(:salary) { 5_876 }

      it 'returns seligible salary equal to salary' do
        expect(subject.eligible_salary).to eq(salary)
      end
      
      it 'returns employee_percent of 1' do
        expect(subject.employee_percent).to eq(1)
      end

      it 'returns employer_percent of 1' do
        expect(subject.employer_percent).to eq(1)
      end
    end 

  end
end
