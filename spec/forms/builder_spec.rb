RSpec.describe Wpcc::Builder, type: :form do
  describe '#object_error_class' do
    let(:template) do
      Object.new
            .extend(ActionView::Helpers::FormHelper)
            .extend(ActionView::Helpers::FormOptionsHelper)
    end
    let(:your_details_form) { Wpcc::YourDetailsForm.new }

    subject(:object_error_class) do
      Wpcc::Builder.new(:form, your_details_form, template, {})
                   .object_error_class
    end

    it 'uses a custom object error handler class' do
      expect(object_error_class).to eq(Wpcc::ObjectError)
    end
  end
end
