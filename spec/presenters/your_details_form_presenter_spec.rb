RSpec.describe Wpcc::YourDetailsFormPresenter do
  subject do
    described_class.new(
      your_details_form: your_details_form,
      translator: translator
    )
  end
  let(:your_details_form) { Wpcc::YourDetailsForm.new }
  let(:translator) do
    ->(value) { value.sub(/wpcc.details.options.frequency./, '') }
  end

  describe '#gender_options' do
    it 'returns an array of translation keys and values for genders' do
      translation_keys = [
        'wpcc.details.options.gender.male',
        'wpcc.details.options.gender.female'
      ]
      gender_values = %w[male female]
      expected_result = Hash[translation_keys.zip(gender_values)].to_a

      expect(subject.gender_options).to eq(expected_result)
    end
  end

  describe '#salary_frequency_options' do
    it 'returns an array of translation keys for salary_frequencies' do
      translation_keys = %w[year month fourweeks week].map do |frequency|
        "wpcc.details.options.salary_frequency.#{frequency}"
      end
      frequency_values = %w[year month fourweeks week]
      expected_result = Hash[translation_keys.zip(frequency_values)].to_a

      expect(subject.salary_frequency_options).to eq(expected_result)
    end
  end
end
