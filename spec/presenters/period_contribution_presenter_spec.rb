RSpec.describe Wpcc::PeriodContributionPresenter do
  subject do
    described_class.new(period_contribution, view_context: view_context)
  end

  let(:period_contribution) { Wpcc::PeriodContribution.new }
  let(:view_context) { double(:view_context) }

  describe '#title' do
    it 'converts the name to a more readable format' do
      expect(view_context)
        .to receive(:t)
        .with('wpcc.results.period_title.april_2017_march_2018')
        .and_return('Today - March 2018')

      period_contribution.name = 'april_2017_march_2018'
      expect(subject.title).to eq('Today - March 2018')
    end
  end
end
