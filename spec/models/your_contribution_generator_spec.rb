require 'spec_helper'

describe Wpcc::YourContributionGenerator, type: :model do
  subject do
    described_class.new(
      salary_per_year: salary_per_year,
      contribution_preference: contribution_preference
    )
  end

  describe '#contribution_calculator' do
    context 'minimum contribution' do
      let(:salary_per_year) { 45_000 }
      let(:contribution_preference) { 'minimum' }
      let(:minimum_contribution_calculator) do
        double('MinimumContributionCalculator')
      end

      it 'creates a MinimumContributionCalculator' do
        expect(Wpcc::MinimumContributionCalculator)
          .to receive(:new)
          .with(salary_per_year, contribution_preference)
          .and_return(minimum_contribution_calculator)

        subject.contribution_calculator
      end
    end

    context 'full contribution' do
      let(:salary_per_year) { 25_000 }
      let(:contribution_preference) { 'full' }
      let(:full_contribution_calculator) do
        double('FullContributionCalculator')
      end

      it 'creates a FullContributionCalculator' do
        expect(Wpcc::FullContributionCalculator)
          .to receive(:new)
          .with(salary_per_year, contribution_preference)
          .and_return(full_contribution_calculator)

        subject.contribution_calculator
      end
    end
  end
end
