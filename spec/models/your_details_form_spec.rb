require 'spec_helper'

describe Wpcc::YourDetailsForm, type: :model do
  subject { described_class.new(age: 32, gender: 'f', salary: 35000) }

  describe 'validations' do
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:salary) }
    it { should validate_inclusion_of(:gender).in_array %w(m f) }
  end
end
