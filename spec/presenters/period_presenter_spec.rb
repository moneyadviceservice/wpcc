RSpec.describe Wpcc::PeriodPresenter do
  subject do
    described_class.new(period, view_context: view_context)
  end

  let(:period) { Wpcc::Period.new }
  let(:view_context) { double(:view_context) }

  before do
    allow(subject).to receive(:view_context)
      .and_return(ActionController::Base.new.view_context)
  end

  describe '#title' do
    it 'converts the name to a more readable format' do
      period.name = 'current'
      expect(subject.title).to eq('Now')
    end
  end

  describe '#employee_percent' do
    it 'formats values with two decimal values' do
      period.employee_percent = 1.0
      expect(subject.employee_percent).to eq('1%')
    end
  end

  describe '#employer_percent' do
    it 'formats values with two decimal values' do
      period.employer_percent = 2.5
      expect(subject.employer_percent).to eq('3%')
    end
  end
end
