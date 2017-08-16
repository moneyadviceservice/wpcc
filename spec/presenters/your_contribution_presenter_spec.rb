RSpec.describe Wpcc::YourContributionPresenter do
  subject do
    described_class.new(object, view_context: context)
  end

  let(:object) { double(Wpcc::ContributionCalculator, eligible_salary: 19_124) }
  let(:context) { ActionController::Base.new.view_context }
  let(:session) { { contribution_preference: 'minimum' } }

  before do
    allow(context).to receive(:session).and_return(session)
  end

  describe '#formatted_eligible_salary' do
    it 'formats a number to a currency with 2 decimal places' do
      expect(subject.formatted_eligible_salary).to eq('£19,124')
    end
  end

  describe '#upper_earnings_threshold' do
    it 'gets the upper earnings threshold and formats it' do
      expect(subject.upper_earnings_threshold).to eq('£45,000')
    end
  end

  describe '#lower_earnings_threshold' do
    it 'gets the lower earnings threshold and formats it' do
      expect(subject.lower_earnings_threshold).to eq('£5,876')
    end
  end

  describe '#earnings_description' do
    context 'full salary' do
      let(:session) { { contribution_preference: 'full' } }
      it 'should return full salary description' do
        qualifying_earnings =
          'Contributions will be made on your salary of £19,124 per year.'
        expect(subject.earnings_description).to eq qualifying_earnings
      end
    end

    context 'qualifying earnings' do
      let(:session) { { contribution_preference: 'minimum' } }
      it 'should return qualifying earnings description' do
        # rubocop:disable LineLength
        qualifying_earnings =
          'Contributions will be made on your qualifying earnings of £19,124 per year.'
        # rubocop:enable LineLength
        expect(subject.earnings_description).to eq qualifying_earnings
      end
    end
  end
end
