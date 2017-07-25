RSpec.describe Wpcc::YourResultsPageHelper, type: :helper do
  subject { helper.earning_below_tax_relief_threshold?(salary) }

  describe 'TAX_RELIEF_THRESHOLD_RATE' do
    it 'should be £11,500' do
      expect(described_class::TAX_RELIEF_THRESHOLD_RATE).to eq(11_500)
    end
  end

  describe '#earning_below_tax_relief_threshold?' do
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
end
