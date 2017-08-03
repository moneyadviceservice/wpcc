RSpec.describe Wpcc::LegalPeriodPresenter do
  subject do
    described_class.new(legal_period, view_context: view_context)
  end

  let(:legal_period) { Wpcc::LegalPeriod.new }
  let(:view_context) { double(:view_context) }

  before do
    allow(subject).to receive(:view_context)
      .and_return(ActionController::Base.new.view_context)
  end

  describe '#title' do
    it 'converts the name to a more readable format' do
      legal_period.name = 'april_2017_march_2018'
      expect(subject.title).to eq('Now')
    end
  end

  describe '#employee_percent' do
    let(:legal_period) { double(employee_percent: 1.0) }

    it 'formats values with two decimal values' do
      expect(subject.employee_percent).to eq('1%')
    end
  end

  describe '#employer_percent' do
    let(:legal_period) { double(employer_percent: 2.5) }

    it 'formats values with two decimal values' do
      expect(subject.employer_percent).to eq('3%')
    end
  end
end
