RSpec.describe Wpcc::SalaryPerYear do
  describe '#convert' do
    subject(:convert) do
      described_class.new(
        salary: salary,
        salary_frequency: salary_frequency
      ).convert
    end

    context 'when yearly frequency' do
      let(:salary) { 380 }
      let(:salary_frequency) { 'year' }

      it 'returns salary' do
        expect(convert).to eq(380)
      end
    end

    context 'when weekly frequency' do
      let(:salary) { 500 }
      let(:salary_frequency) { 'week' }

      it 'returns salary multiplied by 52' do
        expect(convert).to eq(26_000)
      end
    end

    context 'when monthly frequency' do
      let(:salary) { 1000 }
      let(:salary_frequency) { 'month' }

      it 'returns salary multiplied by 12' do
        expect(convert).to eq(12_000)
      end
    end

    context 'when non-existent frequency' do
      let(:salary) { 1000 }
      let(:salary_frequency) { 'non-existent' }

      it 'raises an exception' do
        expect do
          convert
        end.to raise_exception(
          RuntimeError,
          "Salary frequency 'non-existent' is not supported."
        )
      end
    end
  end
end
