RSpec.shared_examples_for 'an earnings conditional message' do
  let(:session) { { contribution_preference: 'minimum' } }

  before do
    allow(context).to receive(:session).and_return(session)
    allow(subject).to receive(:eligible_salary).and_return(19_124)
  end

  describe '#formatted_eligible_salary' do
    it 'formats a number to a currency with 2 decimal places' do
      expect(subject.formatted_eligible_salary).to eq('£19,124')
    end
  end

  describe '#earnings_description' do
    before do
      expect(subject).to receive(:earnings_description_key)
        .and_return('contributions')
    end

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
