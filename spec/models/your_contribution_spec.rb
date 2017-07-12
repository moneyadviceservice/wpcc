RSpec.describe Wpcc::YourContribution do
  describe '.generate' do
    subject do
      described_class.generate(salary, contribution_preference)
    end
    let(:salary) { 24_145 }

    context 'when is minimum contribution preference' do
      let(:contribution_preference) { 'minimum' }
      let(:calculator) do
        double(
          eligible_salary: 12_999,
          employee_percent: 1,
          employer_percent: 0
        )
      end

      it 'returns your contribution based on minimum calculator' do
        expect(
          Wpcc::MinimumContributionCalculator
        ).to receive(:new).and_return(calculator)

        expect(subject.eligible_salary).to eq(calculator.eligible_salary)
      end
    end

    context 'when is full contribution preference' do
      let(:contribution_preference) { 'full' }
      let(:calculator) do
        double(
          eligible_salary: 45_540,
          employee_percent: 1,
          employer_percent: 1
        )
      end

      it 'returns your contribution based on full calculator' do
        expect(
          Wpcc::FullContributionCalculator
        ).to receive(:new).and_return(calculator)

        expect(subject.eligible_salary).to eq(calculator.eligible_salary)
      end
    end
  end
end
