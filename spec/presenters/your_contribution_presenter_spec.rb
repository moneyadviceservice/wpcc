RSpec.describe Wpcc::YourContributionPresenter do
  subject do
    described_class.new(object, view_context: context)
  end

  let(:object) { double(Wpcc::ContributionCalculator, eligible_salary: 19_124) }
  let(:context) { ActionController::Base.new.view_context }

  describe '#formatted_eligible_salary' do
    it 'formats a number to a currency with 2 decimal places' do
      expect(subject.formatted_eligible_salary).to eq('£19,124.00')
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
end
