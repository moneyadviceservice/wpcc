RSpec.describe Wpcc::PeriodContributionPresenter do
  subject do
    described_class.new(period_contribution, view_context: view_context)
  end

  let(:period_contribution) { Wpcc::PeriodContribution.new }
  let(:view_context) { double(:view_context) }

  before do
    allow(subject).to receive(:view_context)
      .and_return(ActionController::Base.new.view_context)
  end

  describe '#title' do
    it 'converts the name to a more readable format' do
      period_contribution.name = 'april_2017_march_2018'
      expect(subject.title).to eq('Now')
    end
  end

  describe '#employee_contribution' do
    let(:period_contribution) { double(employee_contribution: 1.0) }

    it 'formats values with two decimal values' do
      expect(subject.employee_contribution).to eq('£1.00')
    end
  end

  describe '#employer_contribution' do
    let(:period_contribution) { double(employer_contribution: 2.5) }

    it 'formats values with two decimal values' do
      expect(subject.employer_contribution).to eq('£2.50')
    end
  end

  describe '#tax_relief' do
    let(:period_contribution) { double(tax_relief: 1.99) }

    it 'returns a message with the formatted value' do
      expect(subject.tax_relief).to eq('(includes tax relief of £1.99)')
    end
  end
end
