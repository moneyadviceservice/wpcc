RSpec.describe Wpcc::YourDetailsFormPresenter do
  subject do
    described_class.new(
      your_details_form: your_details_form,
      translator: translator
    )
  end
  let(:your_details_form) { Wpcc::YourDetailsForm.new }
  let(:translator) do
    ->(value) { value.sub(/wpcc.details.options.frequency./, '').capitalize }
  end

  describe '#gender_options' do
    it 'returns an array of translation keys for genders' do
      translation_keys = [
        'Wpcc.details.options.gender.male',
        'Wpcc.details.options.gender.female'
      ]
      expect(subject.gender_options).to eq translation_keys
    end
  end

  describe '#salary_frequency_options' do
    it 'returns an array of translation keys for salary_frequencies' do
      translation_keys = %w[year month fourweeks week].map do |frequency|
        "Wpcc.details.options.salary_frequency.#{frequency}"
      end

      expect(subject.salary_frequency_options).to eq translation_keys
    end
  end
end
