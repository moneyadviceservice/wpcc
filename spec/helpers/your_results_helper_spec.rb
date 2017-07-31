RSpec.describe Wpcc::YourResultsHelper, type: :helper do
  subject do
    helper.earning_below_tax_relief_threshold?(salary, salary_frequency)
  end

  describe 'TAX_RELIEF_THRESHOLD_RATE' do
    context 'annual rate' do
      it 'should be £11,500' do
        expect(described_class::TAX_RELIEF_THRESHOLD_RATE[:year]).to eq(11_500)
      end
    end

    context 'monthly rate' do
      it 'should be £958.33' do
        expect(described_class::TAX_RELIEF_THRESHOLD_RATE[:month]).to eq(958.33)
      end
    end

    context 'four-weekly rate' do
      it 'should be £884.61' do
        expect(described_class::TAX_RELIEF_THRESHOLD_RATE[:fourweeks]).to eq(
          884.61
        )
      end
    end

    context 'weekly rate' do
      it 'should be £221.15' do
        expect(described_class::TAX_RELIEF_THRESHOLD_RATE[:week]).to eq(221.15)
      end
    end
  end

  describe '#earning_below_tax_relief_threshold?' do
    context 'annual rate' do
      let(:salary_frequency) { 'year' }

      context 'salary below threshold' do
        let(:salary) { 6000 }

        it { is_expected.to be_truthy }
      end

      context 'salary equal to threshold' do
        let(:salary) { 11_500 }

        it { is_expected.to be_falsey }
      end

      context 'salary above the threshold' do
        let(:salary) { 16_700 }

        it { is_expected.to be_falsey }
      end
    end

    context 'monthly rate' do
      let(:salary_frequency) { 'month' }

      context 'salary below threshold' do
        let(:salary) { 900 }

        it { is_expected.to be_truthy }
      end

      context 'salary equal to threshold' do
        let(:salary) { 958.33 }

        it { is_expected.to be_falsey }
      end

      context 'salary above the threshold' do
        let(:salary) { 1000 }

        it { is_expected.to be_falsey }
      end
    end

    context 'fortnighyly rate' do
      let(:salary_frequency) { 'fourweeks' }

      context 'salary below threshold' do
        let(:salary) { 700 }

        it { is_expected.to be_truthy }
      end

      context 'salary equal to threshold' do
        let(:salary) { 884.61 }

        it { is_expected.to be_falsey }
      end

      context 'salary above the threshold' do
        let(:salary) { 1000 }

        it { is_expected.to be_falsey }
      end
    end

    context 'weekly rate' do
      let(:salary_frequency) { 'week' }

      context 'salary below threshold' do
        let(:salary) { 100 }

        it { is_expected.to be_truthy }
      end

      context 'salary equal to threshold' do
        let(:salary) { 221.15 }

        it { is_expected.to be_falsey }
      end

      context 'salary above the threshold' do
        let(:salary) { 300 }

        it { is_expected.to be_falsey }
      end
    end
  end
end
