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
  let(:period_filter) { double(Wpcc::PeriodFilter) }

  describe '#highest_employee_percent' do
    let(:employee_percent) { 4 }
    let(:user_input_employee_percent) { 3 }

    it 'returns highest percent between period percent and user percent' do
      expect(Wpcc::Percent).to receive(:choose_highest).with(4, 3).and_return(4)
      period.highest_employee_percent
    end
  end

  describe '#highest_employer_percent' do
    let(:employer_percent) { 5 }
    let(:user_input_employer_percent) { 6 }

    it 'returns highest percent between period percent and user percent' do
      expect(Wpcc::Percent).to receive(:choose_highest).with(5, 6).and_return(6)
      period.highest_employer_percent
    end
  end

  describe '#below_user_contributions' do
    let(:period_filter) do
      double(Wpcc::PeriodFilter,
             user_input_employee_percent: 1,
             user_input_employer_percent: 1)
    end

    context 'when there are no percents' do
      let(:employee_percent) { nil }
      it 'returns false' do
        expect(subject.below_user_contributions?(period_filter)).to be_falsey
      end
    end

    context 'when legal percents are gte percents input by the user' do
      let(:employee_percent) { 10 }
      let(:employer_percent) { 10 }
      it 'returns false' do
        expect(subject.below_user_contributions?(period_filter)).to be_falsey
      end
    end

    context 'when legal percents are less than percents input by the user' do
      let(:employee_percent) { 1 }
      let(:employer_percent) { 1 }
      it 'returns true' do
        expect(subject.below_user_contributions?(period_filter)).to be_truthy
      end
    end
  end
end
