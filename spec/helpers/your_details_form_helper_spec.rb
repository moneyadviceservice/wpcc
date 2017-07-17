RSpec.describe Wpcc::YourDetailsFormHelper, type: :helper do
  describe '.disable_minimum_contribution_option?' do
    subject { helper.disable_minimum_contribution_option? }

    context 'salary lower than threshold' do
      let(:form) do
        Wpcc::YourDetailsForm.new(age: age,
                                  gender: gender,
                                  salary: salary,
                                  salary_frequency: salary_frequency,
                                  contribution_preference: pref)
      end

      before do
        form.valid?
        assign(:your_details_form, form)
      end

      context 'make minimum contribution preference' do
        let(:age)    { 35        }
        let(:gender) { 'female'  }
        let(:salary) { 4000      }
        let(:pref)   { 'minimum' }
        let(:salary_frequency) { 'year' }

        it 'disables minimum contribution option' do
          expect(subject).to be_truthy
        end
      end

      context 'make full contribution preference' do
        let(:age)    { 35       }
        let(:gender) { 'female' }
        let(:salary) { 4000     }
        let(:pref)   { 'full'   }
        let(:salary_frequency) { 'year' }

        it 'enables minimum contribution option' do
          expect(subject).to be_falsey
        end
      end
    end
  end
end
