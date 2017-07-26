RSpec.describe Wpcc::YourDetailsFormPresenter do
  subject do
    described_class.new(your_details_form, view_context: context)
  end

  let(:your_details_form) { Wpcc::YourDetailsForm.new }
  let(:context) { ActionController::Base.new.view_context }

  describe '#gender_options' do
    it 'returns an array of keys and values for gender select options' do
      genders = %w[male female]
      expected_result = genders.map { |gender| [gender.capitalize, gender] }

      expect(subject.gender_options).to eq(expected_result)
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
