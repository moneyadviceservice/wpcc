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

  describe '#required_employer_percent' do
    let(:employer_percent) { 5 }
    let(:user_input_employer_percent) { 6 }

    context 'when user\'s salary is below the minimum threshold' do
      let(:salary) { 5_000 }

      it 'returns the user percent' do
        expect(period.required_employer_percent(salary)).to eq(6)
      end
    end

    context 'when user\'s salary is gte the minimum threshold' do
      let(:salary) { 6_032 }

      it 'returns highest percent between period percent and user percent' do
        expect(Wpcc::Percent)
          .to receive(:choose_highest)
          .with(5, 6)
          .and_return(6)

        period.required_employer_percent(salary)
      end
    end
  end

  describe '#below_user_contributions' do
    let(:period_filter) do
      double(Wpcc::PeriodFilter,
             user_input_employee_percent: 3,
             user_input_employer_percent: 3)
    end

    context 'when legal percents are gte percents input by the user' do
      let(:employee_percent) { 10 }
      let(:employer_percent) { 10 }
      it 'returns false' do
        expect(subject.should_be_filtered_out?(period_filter)).to be_falsey
      end
    end

    context 'when legal percents are less than percents input by the user' do
      let(:employee_percent) { 1 }
      let(:employer_percent) { 1 }
      it 'returns true' do
        expect(subject.should_be_filtered_out?(period_filter)).to be_truthy
      end
    end
  end
end
