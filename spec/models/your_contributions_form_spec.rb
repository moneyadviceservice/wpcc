require 'spec_helper'

describe Wpcc::YourContributionsForm, type: :model do
  subject { described_class.new }

  describe 'minimum combined contributions validation' do
    context 'successful' do
      it 'passes when the sum of employee and employer percents is GTE to 7' do
        subject.employee_percent = 2.0
        subject.employer_percent = 5.0

        expect(subject.valid?).to be_truthy
      end
    end

    context 'failure' do
      it 'fails when the sum of employee and employer percents is below 7' do
        subject.employee_percent = 1.0
        subject.employer_percent = 5.0

        expect(subject.valid?).to be_falsey
      end
    end
  end
end
