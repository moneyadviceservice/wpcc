RSpec.describe Wpcc::MessagePresenter do
  subject do
    described_class.new(object, view_context: context)
  end

  let(:object) do
    double(
      :object,
      salary_below_tax_relief_threshold?: salary_below_tax_relief_threshold?
    )
  end
  let(:salary_below_tax_relief_threshold?) { true }
  let(:context) { ActionController::Base.new.view_context }

  describe '#tax_relief_warning?' do
    context 'message is set to tax_relief_warning' do
      let(:salary_below_tax_relief_threshold?) { true }

      it 'returns true' do
        expect(subject.tax_relief_warning?).to be_truthy
      end
    end

    context 'message is NOT set to tax_relief_warning' do
      let(:salary_below_tax_relief_threshold?) { false }

      it 'returns false' do
        expect(subject.tax_relief_warning?).to be_falsey
      end
    end
  end

  describe '#tax_relief_warning' do
    it 'returns the tax relief warning message' do
      warning = 'If you don’t pay income tax on your earnings, you will only'
      expect(subject.tax_relief_warning.include?(warning)).to be_truthy
    end
  end
end
