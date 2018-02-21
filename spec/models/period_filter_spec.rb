RSpec.describe Wpcc::PeriodFilter do
  let(:periods) do
    {
      current: {
        tax_relief: 20
      },
      some_period: {
        tax_relief: 20,
        employee: 3,
        employer: 4
      },
      period_onwards: {
        tax_relief: 20,
        employee: 5,
        employer: 5
      }
    }
  end

  describe '#periods' do
    let(:user_input_employee_percent) { 1 }
    let(:user_input_employer_percent) { 1 }

    subject do
      described_class.new(
        user_input_employee_percent: user_input_employee_percent,
        user_input_employer_percent: user_input_employer_percent
      )
    end

    it 'returns a Period object for each period in the config file' do
      expect(Wpcc::Period).to receive(:new).exactly(2).times
      subject.periods
    end
  end

  describe '#filter' do
    subject(:filtered_periods) do
      described_class.new(
        user_input_employee_percent: user_input_employee_percent,
        user_input_employer_percent: user_input_employer_percent
      ).filtered_periods
    end

    context 'when only employee contribution is higher than the period' do
      let(:user_input_employee_percent) { 4 }
      let(:user_input_employer_percent) { 1 }

      it 'does not exclude the period' do
        expect(filtered_periods.size).to eq(2)
      end
    end

    context 'when only employer contribution is higher than the period' do
      let(:user_input_employee_percent) { 1 }
      let(:user_input_employer_percent) { 4.5 }

      it 'does not exclude the period' do
        expect(filtered_periods.size).to eq(2)
      end
    end

    context 'when period percent is equal to user percent' do
      let(:user_input_employee_percent) { 3 }
      let(:user_input_employer_percent) { 4 }

      it 'excludes contribution period which is equal to the contributions' do
        expect(filtered_periods.size).to eq(2)
      end
    end

    context 'when contribution period is less than user percents' do
      context 'when one period is less than user percents' do
        let(:user_input_employee_percent) { 4 }
        let(:user_input_employer_percent) { 5 }

        it 'excludes the lower contribution period' do
          expect(filtered_periods.size).to eq(2)
        end
      end
    end
  end
end
