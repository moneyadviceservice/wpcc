require 'spec_helper'

describe Wpcc::YourContributionsForm, type: :model do
  subject { described_class.new }

  describe 'validations' do
    it { should validate_inclusion_of(:employee_percent).in_range(0..100) }
    it { should validate_inclusion_of(:employer_percent).in_range(3..100) }
  end

  describe 'contributions validation' do
    context 'successful' do
      it 'passes when the sum of employee and employer percents is GTE to 8' do
        subject.employee_percent = 2.0
        subject.employer_percent = 6.0

        expect(subject.valid?).to be_truthy
      end
    end

    context 'failure' do
      it 'fails when the sum of employee and employer percents is below 8' do
      end
    end
  end
end
