require 'spec_helper'

describe Wpcc::YourDetailsForm, type: :model do
  subject { described_class.new(age: 32, gender: 'female', salary: 35_000) }

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
      it { should allow_value('full').for(:employer_contribution) }
      it { should allow_value('minimum').for(:employer_contribution) }
      it { should_not allow_value('part').for(:employer_contribution) }
    end
  end
end
