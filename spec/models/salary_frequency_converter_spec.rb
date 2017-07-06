require 'spec_helper'

describe Wpcc::SalaryFrequencyConverter, type: :model do
  subject { described_class }

  describe '.convert' do
    context 'for yearly frequency' do
      it 'returns 1' do
        expect(subject.convert('year')).to eq(1)
      end
    end

    context 'for monthly frequency' do
      it 'returns 12' do
        expect(subject.convert('month')).to eq(12)
      end
    end

    context 'for 4-weekly frequency' do
      it 'returns 13' do
        expect(subject.convert('fourweeks')).to eq(13)
      end
    end

    context 'for weekly frequency' do
      it 'returns 52' do
        expect(subject.convert('week')).to eq(52)
      end
    end
  end
end
