RSpec.describe Wpcc::YourResultsPresenter do
  subject(:presenter) do
    described_class.new(eligible_salary, view_context: view_context)
  end

  let(:eligible_salary) { double(eligible_salary: 39_441) }
  let(:view_context) { double(:view_context) }

  describe '#earnings_description_key' do
    it 'returns "results"' do
      expect(presenter.earnings_description_key).to eq('results')
    end
  end
end
