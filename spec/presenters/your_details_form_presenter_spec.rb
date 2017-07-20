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

  describe '#disabled_class' do
    context 'salary lower than threshold' do
      let(:age) { 35 }
      let(:gender) { 'female' }
      let(:salary) { 4000 }
      let(:salary_frequency) { 'year' }

      let(:your_details_form) do
        Wpcc::YourDetailsForm.new(age: age,
                                  gender: gender,
                                  salary: salary,
                                  salary_frequency: salary_frequency,
                                  contribution_preference: pref)
      end

      before do
        your_details_form.valid?
      end

      context 'make minimum contribution' do
        let(:pref) { 'minimum' }

        it 'disabled minimum contribution option' do
          expect(subject.disabled_class).to eq('disabled')
        end
      end

      context 'make minimum contribution' do
        let(:pref) { 'full' }

        it 'disabled minimum contribution option' do
          expect(subject.disabled_class).to be_nil
        end
      end
    end
  end
end
