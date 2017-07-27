RSpec.describe Wpcc::Period do
  subject(:period) do
    described_class.new(
      name: 'some_period',
      employee_percent: employee_percent,
      employer_percent: employer_percent,
      tax_relief_percent: 20,
      user_input_employee_percent: user_input_employee_percent,
      user_input_employer_percent: user_input_employer_percent
    )
  end
  let(:employee_percent) { 10 }
  let(:employer_percent) { 10 }
  let(:user_input_employee_percent) { 1 }
  let(:user_input_employer_percent) { 2 }

  describe '#employee_percent' do
    let(:employee_percent) { 4 }
    let(:user_input_employee_percent) { 3 }

    before do
      expect(Wpcc::Percent).to receive(:choose_highest).with(4, 3).and_return(4)
    end

    it 'returns highest percent between period percent and user percent' do
      expect(period.employee_percent).to eq(4)
    end
  end

  describe '#employer_percent' do
    let(:employer_percent) { 5 }
    let(:user_input_employer_percent) { 6 }

    before do
      expect(Wpcc::Percent).to receive(:choose_highest).with(5, 6).and_return(6)
    end

    it 'returns highest percent between period percent and user percent' do
      expect(period.employer_percent).to eq(6)
    end
  end
end
