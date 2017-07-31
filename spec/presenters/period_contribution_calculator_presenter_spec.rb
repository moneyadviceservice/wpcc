RSpec.describe Wpcc::PeriodContributionCalculatorPresenter do
  subject do
    described_class.new(pcc, view_context: view_context)
  end

  let(:pcc) { Wpcc::PeriodContribution.new }
  let(:view_context) { double(:view_context) }

  before do
    allow(subject).to receive(:view_context)
      .and_return(ActionController::Base.new.view_context)
  end

  describe '#title' do
    it 'converts the name to a more readable format' do
      pcc.name = 'april_2017_march_2018'
      expect(subject.title).to eq('Now')
    end
  end

  describe '#employee_percent' do
    let(:pcc) { double(employee_percent: 1.0) }

    it 'formats values with two decimal values and a "%"' do
      expect(subject.employee_percent).to eq('%1.00')
    end
  end

  describe '#employer_percent' do
    let(:pcc) { double(employer_percent: 3) }

    it 'formats values with two decimal values and a "%"' do
      expect(subject.employer_percent).to eq('%3.00')
    end
  end
end
