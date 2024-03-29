RSpec.describe Wpcc::YourDetailsFormPresenter do
  subject do
    described_class.new(your_details_form, view_context: context)
  end

  let(:your_details_form) { Wpcc::YourDetailsForm.new }
  let(:context) { ActionController::Base.new.view_context }

  describe '#activate_disabled_callout' do
    context 'salary lower than threshold' do
      let(:age) { 35 }
      let(:salary) { 4000 }
      let(:salary_frequency) { 'year' }

      let(:your_details_form) do
        Wpcc::YourDetailsForm.new(age: age,
                                  salary: salary,
                                  salary_frequency: salary_frequency,
                                  contribution_preference: pref)
      end

      before do
        your_details_form.valid?
      end

      context 'when minimum contribution is selected' do
        let(:pref) { 'minimum' }

        it 'returns an active class name' do
          class_name = 'details__callout--active'
          expect(subject.activate_disabled_callout).to eq(class_name)
        end
      end

      context 'when full contribution is selected' do
        let(:pref) { 'full' }

        it 'returns an inactive class name' do
          class_name = 'details__callout--inactive'
          expect(subject.activate_disabled_callout).to eq(class_name)
        end
      end
    end
  end
end
