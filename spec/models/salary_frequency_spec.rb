RSpec.describe Wpcc::SalaryFrequency do
  subject do
    described_class.new(
      locale: locale,
      params_salary_frequency: params_salary_frequency,
      session_salary_frequency: session_salary_frequency
    )
  end

  let(:params_salary_frequency) { nil }
  let(:locale) { :en }

  describe '#to_adj' do
    context 'when english' do
      context 'for weekly salary_frequency' do
        let(:params_salary_frequency) { 'week' }
        let(:session_salary_frequency) { 'week' }
        it 'returns the frequency adjective' do
          expect(subject.to_adj).to eq('weekly')
        end
      end

      context 'for 4-weekly salary_frequency' do
        let(:params_salary_frequency) { 'fourweeks' }
        let(:session_salary_frequency) { 'fourweeks' }
        it 'returns the frequency adjective' do
          expect(subject.to_adj).to eq('4-weekly')
        end
      end

      context 'for montly salary_frequency' do
        let(:params_salary_frequency) { 'month' }
        let(:session_salary_frequency) { 'month' }
        it 'returns the frequency adjective' do
          expect(subject.to_adj).to eq('monthly')
        end
      end
      context 'for 4-weekly salary_frequency' do
        let(:params_salary_frequency) { 'year' }
        let(:session_salary_frequency) { 'year' }
        it 'returns the frequency adjective' do
          expect(subject.to_adj).to eq('annual')
        end
      end
    end

    context 'when welsh' do
      let(:locale) { :cy }

      context 'for weekly salary_frequency' do
        let(:params_salary_frequency) { 'week' }
        let(:session_salary_frequency) { 'week' }
        it 'returns the frequency adjective' do
          expect(subject.to_adj).to eq('wythnosol')
        end
      end

      context 'for 4-weekly salary_frequency' do
        let(:params_salary_frequency) { 'fourweeks' }
        let(:session_salary_frequency) { 'fourweeks' }
        it 'returns the frequency adjective' do
          expect(subject.to_adj).to eq('bob 4 wythnos')
        end
      end

      context 'for montly salary_frequency' do
        let(:params_salary_frequency) { 'month' }
        let(:session_salary_frequency) { 'month' }
        it 'returns the frequency adjective' do
          expect(subject.to_adj).to eq('misol')
        end
      end
      context 'for 4-weekly salary_frequency' do
        let(:params_salary_frequency) { 'year' }
        let(:session_salary_frequency) { 'year' }
        it 'returns the frequency adjective' do
          expect(subject.to_adj).to eq('blynyddol')
        end
      end
    end
  end

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
