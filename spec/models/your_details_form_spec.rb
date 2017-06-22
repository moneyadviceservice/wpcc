require 'spec_helper'

describe Wpcc::YourDetailsForm, type: :model do
  subject { described_class.new(age: 32, gender: 'f', salary: 35_000) }

  describe 'validations' do
    it { should validate_presence_of(:age) }
    it { should validate_inclusion_of(:gender).in_array %w[m f] }
    it { should validate_numericality_of(:salary) }
    it { should allow_value(12).for(:salary) }
    it { should_not allow_value(0).for(:salary) }
    it { should_not allow_value(-1).for(:salary) }
    it { should_not allow_value(12.4).for(:salary) }
  end
end
