RSpec.describe Wpcc::SalaryFrequency do
  subject do
    described_class.new(
      params_salary_frequency: params_salary_frequency,
      session_salary_frequency: session_salary_frequency
    )
  end

  let(:params_salary_frequency) { nil }

  describe '#to_i' do
    let(:session_salary_frequency) { 'month' }

    it 'converts the string to total units per year' do
      expect(subject.to_i).to eq(12)
    end
  end

  describe '#to_s' do
    let(:session_salary_frequency) { 'year' }

    context 'when salary frequency is annual' do
      context 'when the your details form is submitted' do
        it 'returns month' do
          expect(subject.to_s).to eq('month')
        end
      end

      context 'the salary frequency selector has been submitted on step 3' do
        let(:params_salary_frequency) { 'year' }
        it 'returns year' do
          expect(subject.to_s).to eq('year')
        end
      end
    end

    context 'when salary frequency is monthly' do
      let(:session_salary_frequency) { 'month' }
      it 'returns itself' do
        expect(subject.to_s).to eq('month')
      end
    end
  end
end
