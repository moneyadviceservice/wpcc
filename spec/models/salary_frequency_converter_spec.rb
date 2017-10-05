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

  describe '.to_string' do
    context 'for 1' do
      it 'returns year' do
        expect(subject.to_string(1)).to eq('year')
      end
    end
    context 'for 12' do
      it 'returns month' do
        expect(subject.to_string(12)).to eq('month')
      end
    end
    context 'for 13' do
      it 'returns fourweeks' do
        expect(subject.to_string(13)).to eq('fourweeks')
      end
    end
    context 'for 52' do
      it 'returns week' do
        expect(subject.to_string(52)).to eq('week')
      end
    end
  end
end
