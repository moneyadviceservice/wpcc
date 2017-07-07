RSpec.describe Wpcc::PeriodContributionPresenter do
  subject do
    described_class.new(
      period_contribution: period_contribution,
      translator: translator
    )
  end
  
  let(:period_contribution) { Wpcc::PeriodContribution.new }

  let(:translator) do
    ->(value) { value.sub(/wpcc.results.period_title./, '') }
  end

  describe '#title' do
    
    it 'converts the name to a more readable format' do
      # binding.pry
      period_contribution.name = 'april_2017_march_2018'
      expect(subject.title).to eq('Today - March 2018')
    end
  end
end
