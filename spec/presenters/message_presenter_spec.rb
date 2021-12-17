RSpec.describe Wpcc::MessagePresenter do
  subject { described_class.new(object, view_context: context) }

  let(:context) { ActionController::Base.new.view_context }
  let(:object) do
    double(
      :object,
      text: text,
      salary_below_tax_relief_threshold?: salary_below_tax_relief_threshold?,
      salary_below_pension_limit?: salary_below_pension_limit?
    )
  end
  let(:text) { nil }
  let(:salary_below_tax_relief_threshold?) { true }
  let(:salary_below_pension_limit?) { true }

  describe '#minimum_contribution?' do
    before do
      allow(context).to receive(:session).and_return(session)
    end

    context 'select part salary' do
      let(:session) { { contribution_preference: 'minimum' } }

      it 'returns true' do
        expect(subject.minimum_contribution?).to be_truthy
      end
    end

    context 'select full salary' do
      let(:session) { { contribution_preference: 'full' } }

      it 'returns false' do
        expect(subject.minimum_contribution?).to be_falsey
      end
    end
  end

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
    it 'returns the tax relief warning message' do
      warning = 'If you don’t pay income tax on your earnings, you will only'
      expect(subject.tax_relief_warning.include?(warning)).to be_truthy
    end
  end

  describe '#your_details_summary' do
    context 'for minimum contribution_preference' do
      let(:hash) do
        {
          age: 23,
          salary: 6_000,
          salary_frequency: 'year',
          contribution_preference: 'Minimum'
        }
      end

      it 'formats the session details to a string' do
        string = '23 years, £6,000 per year, part salary'
        expect(subject.your_details_summary(hash)).to eq(string)
      end
    end

    context 'for full contribution_preference' do
      let(:hash) do
        {
          age: 43,
          salary: 26_000,
          salary_frequency: 'week',
          contribution_preference: 'Full'
        }
      end
      it 'formats the session details to a string' do
        string = '43 years, £26,000 per week, full salary'
        expect(subject.your_details_summary(hash)).to eq(string)
      end
    end
  end

  describe '#employee_contribution_tip' do
    before do
      allow(context).to receive(:session).and_return(session)
    end
    let(:session) do
      {
        contribution_preference: 'minimum',
        salary: 25_000,
        salary_frequency: 'year'
      }
    end

    context 'when the salary is below tax relief threshold' do
      let(:salary_below_pension_limit?) { true }
      it 'returns information message' do
        string = 'At your salary level there is no legal minimum contribution' \
          ' but your workplace pension scheme may have a set minimum.'\
          ' Check with your employer.'
        expect(subject.employee_contribution_tip).to eq string
      end
    end
  end
end
