require 'spec_helper'

describe Wpcc::MinimumContributionCalculator, type: :model do
  subject do 
    described_class.new(salary, contribution_preference).calculate
  end

  describe '#calculate' do
    let (:contribution_preference) { 'minimum' }

    context 'salary greater than Upper Earnings Threshold' do
      let (:salary) { 50_000 }

      it 'returns eligible salary of 39,124' do
        expect(subject.eligible_salary).to eq(39_124)
      end

      it 'returns employee_percent of 1' do
        expect(subject.employee_percent).to eq(1)
      end

      it 'returns employer_percent of 1' do
        expect(subject.employer_percent).to eq(1)
      end
    end

    context 'salary less than or equal to Upper Earnings Threshold' do
      let (:salary) { 45_000 }

      it 'returns 39,124 for eligible salary' do
        expect(subject.eligible_salary).to eq(39_124)
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
