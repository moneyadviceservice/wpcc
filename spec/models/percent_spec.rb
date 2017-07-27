RSpec.describe Wpcc::Percent do
  describe '.choose_highest' do
    subject do
      described_class.choose_highest(period_percent, user_percent)
    end

    context 'when period does not have percentage' do
      let(:period_percent) { nil }
      let(:user_percent) { 3 }

      it 'returns user percent' do
        expect(subject).to eq(3)
      end
    end

    context 'when period percent is higher than user percentage' do
      let(:period_percent) { 4 }
      let(:user_percent) { 3 }

      it 'returns period percent' do
        expect(subject).to eq(4)
      end
    end

    context 'when user percent is higher than period percentage' do
      let(:period_percent) { 4 }
      let(:user_percent) { 5 }

      it 'returns user percent' do
        expect(subject).to eq(5)
      end
    end
  end
end
