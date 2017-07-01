require 'spec_helper'

describe Wpcc::YourContributionsForm, type: :model do
  subject { described_class.new }

  describe 'validations' do
    it { should validate_inclusion_of(:employee_contribution).in_range (0..100) }
    it { should validate_inclusion_of(:employer_contribution).in_range (0..100) }
  end
end
