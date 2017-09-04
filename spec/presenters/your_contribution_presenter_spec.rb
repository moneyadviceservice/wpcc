RSpec.describe Wpcc::YourContributionPresenter do
  include_examples 'an earnings conditional message'

  subject(:presenter) do
    described_class.new(object, view_context: context)
  end

  let(:object) { double(Wpcc::ContributionCalculator, eligible_salary: 19_124) }
  let(:context) { ActionController::Base.new.view_context }

  describe '#earnings_description_key' do
    it 'returns "contributions"' do
      expect(presenter.earnings_description_key).to eq('contributions')
    end
  end
end
