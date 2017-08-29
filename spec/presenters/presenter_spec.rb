RSpec.describe Wpcc::Presenter do
  subject do
    described_class.new(object, view_context: context)
  end

  let(:object) { double(:object) }
  let(:context) { ActionController::Base.new.view_context }

  describe '#salary_frequency_options' do
    let(:expected_result) do
      [
        ['per Year', 'year',
         { data: { unit_converter: 1, frequency_adjective: 'annual' } }],
        ['per Month', 'month',
         { data: { unit_converter: 12, frequency_adjective: 'monthly' } }],
        ['per 4 weeks', 'fourweeks',
         { data: { unit_converter: 13, frequency_adjective: '4-weekly' } }],
        ['per Week', 'week',
         { data: { unit_converter: 52, frequency_adjective: 'weekly' } }]
      ]
    end

    it 'returns translation keys and data-attributes for salary_frequencies' do
      expect(subject.salary_frequency_options).to eq(expected_result)
    end
  end

  describe '#formatted_upper_earnings' do
    it 'gets the upper earnings threshold and formats it' do
      expect(subject.formatted_upper_earnings).to eq('£45,000')
    end
  end

  describe '#formatted_lower_earnings' do
    it 'gets the lower earnings threshold and formats it' do
      expect(subject.formatted_lower_earnings).to eq('£5,876')
    end
  end

  describe '#formatted_currency - formats a number with a "£" sign and' do
    let(:number) { 5_876 }
    context 'when a precision is provided' do
      it 'the provided number of decimal places' do
        expect(subject.formatted_currency(5_876, precision: 0)).to eq('£5,876')
      end
    end

    context 'when NO precision is provided' do
      it 'the default number of decimal places, i.e. 2' do
        expect(subject.formatted_currency(5_876)).to eq('£5,876.00')
      end
    end
  end
end
