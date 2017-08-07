RSpec.describe Wpcc::SalaryFrequency do
  subject do
    described_class.new(
      params_salary_frequency: params_salary_frequency,
      session_salary_frequency: session_salary_frequency
    )
  end

  let(:params_salary_frequency) { nil }
  let(:session_salary_frequency) { 'month' }

  describe '#to_i' do
    it 'converts the string to total units per year' do
      expect(subject.to_i).to eq(12)
    end
  end

  describe '#to_s' do
    context 'when the params_salary_frequency is present' do
      let(:params_salary_frequency) { 'year' }
      it 'calculates results by year' do
        expect(subject.to_s).to eq('year')
      end
    end

    context 'when the params_salary_frequency is NOT present' do
      let(:session_salary_frequency) { 'year' }
      it 'calculates results by year' do
        expect(subject.to_s).to eq('month')
      end
    end
  end
end
