RSpec.describe Wpcc::Presenter do
  subject do
    described_class.new(object, view_context: view_context)
  end

  let(:object) { double(:object) }
  let(:view_context) { double(:view_context) }

  describe '#salary_frequency_options' do
    let(:salary_frequency_values) { %w[year month fourweeks week] }
    let(:salary_frequencies) do
      ['per Year', 'per Month', 'per 4 weeks', 'per Week']
    end

    it 'returns an array of translation keys for salary_frequencies' do
      translation_keys = salary_frequency_values.map do |frequency|
        "wpcc.details.options.salary_frequency.#{frequency}"
      end
      translations = Hash[translation_keys.zip(salary_frequencies)]

      translations.each do |key, value|
        expect(view_context)
          .to receive(:t)
          .with(key)
          .and_return(value)
      end

      expected_result = Hash[
        salary_frequencies.zip(salary_frequency_values)
      ].to_a
      expect(subject.salary_frequency_options).to eq(expected_result)
    end
  end
end
