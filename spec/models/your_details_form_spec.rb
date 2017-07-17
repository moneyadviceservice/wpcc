require 'spec_helper'

describe Wpcc::YourDetailsForm, type: :model do
  let(:salary)                  { 35_000 }
  let(:salary_frequency)        { 'year' }
  let(:contribution_preference) { 'full' }

  subject do
    described_class.new(age: 32,
                        gender: 'female',
                        salary: salary,
                        salary_frequency: salary_frequency,
                        contribution_preference: contribution_preference)
  end

  describe 'validations' do
    context 'age' do
      it { should validate_presence_of(:age) }
    end

    context 'gender' do
      it { should validate_inclusion_of(:gender).in_array %w[male female] }
    end

    context 'salary' do
      it { should validate_numericality_of(:salary) }
      it { should allow_value(12).for(:salary) }
      it { should_not allow_value('foo').for(:salary) }
      it { should_not allow_value(0).for(:salary) }
      it { should_not allow_value(-1).for(:salary) }
      it { should_not allow_value(12.4).for(:salary) }
    end

    context 'salary_frequency' do
      it { should allow_value('year').for(:salary_frequency) }
      it { should allow_value('month').for(:salary_frequency) }
      it { should allow_value('fourweeks').for(:salary_frequency) }
      it { should allow_value('year').for(:salary_frequency) }
      it { should_not allow_value('day').for(:salary_frequency) }
    end

    context 'contribution' do
      it { should allow_value('full').for(:contribution_preference) }
      it { should allow_value('minimum').for(:contribution_preference) }
      it { should_not allow_value('part').for(:contribution_preference) }
    end

    context 'low salary threshold' do
      context 'minimum contribution' do
        let(:salary)                  { 5000      }
        let(:salary_frequency)        { 'year'    }
        let(:contribution_preference) { 'minimum' }

        it 'should not allow low salary to be calculated on min contribution' do
          expect(subject).to_not be_valid
          expect(subject.errors.keys).to include(:contribution_preference)
        end
      end

      context 'full contribution' do
        let(:salary)                  { 5000   }
        let(:salary_frequency)        { 'year' }
        let(:contribution_preference) { 'full' }

        it 'should allow low salary to be calculated on full contribution' do
          expect(subject).to be_valid
        end
      end

      context 'when salary frequency does not exist' do
        let(:salary)                  { 5000 }
        let(:salary_frequency)        { 'does_not_exist' }
        let(:contribution_preference) { 'minimum' }

        it 'should not validate' do
          subject.valid?
          expect(subject.errors.keys).to_not include(:contribution_preference)
        end
      end
    end
  end
end
