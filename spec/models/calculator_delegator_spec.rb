require 'spec_helper'

describe Wpcc::CalculatorDelegator, type: :model do
  subject { described_class.new(salary, contribution_preference) }

  describe '#delegate' do

    context 'minimum contribution' do
      let(:salary) { 45_000 }
      let(:contribution_preference) { 'minimum' }
      let(:minimum_contribution_calculator) do 
        double('MinimumContributionCalculator')
      end

      it 'creates a MinimumContributionCalculator' do
        expect(Wpcc::MinimumContributionCalculator)
          .to receive(:new)
          .with(salary, contribution_preference)
          .and_return(minimum_contribution_calculator)

        expect(minimum_contribution_calculator)
          .to receive(:calculate)

        subject.delegate
      end

      it 'returns a YourContribution object' do
        expect(subject.delegate).to be_a Wpcc::YourContribution
      end
    end

    context 'full contribution' do
      let(:salary) { 25_000 }
      let(:contribution_preference) { 'full' }
      let(:full_contribution_calculator) do 
        double('FullContributionCalculator')
      end

      it 'creates a FullContributionCalculator' do
        expect(Wpcc::FullContributionCalculator)
          .to receive(:new)
          .with(salary, contribution_preference)
          .and_return(full_contribution_calculator)

        expect(full_contribution_calculator)
          .to receive(:calculate)

        subject.delegate
      end

      it 'returns a YourContribution object' do
        expect(subject.delegate).to be_a Wpcc::YourContribution
      end
    end
  end
end
