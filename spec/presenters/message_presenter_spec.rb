RSpec.describe Wpcc::MessagePresenter do
  subject { described_class.new(object, view_context: context) }

  let(:context) { ActionController::Base.new.view_context }
  let(:object) do
    double(
      :object,
      text: text,
      salary_below_tax_relief_threshold?: salary_below_tax_relief_threshold?
    )
  end
  let(:salary_below_tax_relief_threshold?) { true }

  describe '#manually_opt_in_message?' do
    context 'when the text is manually_opt_in' do
      let(:text) { :manually_opt_in }

      before do
        allow(object).to receive(:manually_opt_in?).and_return(manually_opt_in?)
      end

      context 'when manually opt in is true' do
        let(:manually_opt_in?) { true }

        it 'returns true' do
          expect(subject).to be_manually_opt_in_message
        end
      end

      context 'when manually opt in is false' do
        let(:manually_opt_in?) { false }

        it 'returns false' do
          expect(subject).to_not be_manually_opt_in_message
        end
      end
    end

    context 'when the text is nil' do
      let(:text) { nil }

      it 'returns false' do
        expect(subject).to_not be_manually_opt_in_message
      end
    end

    context 'when the text is something else' do
      let(:text) { :something_else }

      it 'returns false' do
        expect(subject).to_not be_manually_opt_in_message
      end
    end
  end

  describe '#manually_opt_in_message?' do
    let(:text) { :manually_opt_in }

    it 'returns the manually_opt_in translation' do
      result = 'Your employer will not automatically enrol you into a workplace'
      expect(subject.manually_opt_in_message.include?(result)).to be_truthy
    end
  end

  describe '#tax_relief_warning?' do
    let(:text) { nil }

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
    let(:text) { nil }
    it 'returns the tax relief warning message' do
      warning = 'If you don’t pay income tax on your earnings, you will only'
      expect(subject.tax_relief_warning.include?(warning)).to be_truthy
    end
  end
end
