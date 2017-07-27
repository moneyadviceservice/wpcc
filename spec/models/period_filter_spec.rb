RSpec.describe Wpcc::PeriodFilter do
  before do
    stub_const('Wpcc::PeriodFilter::PERIODS', periods)
  end

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

  describe '#filter' do
    subject(:filter) do
      described_class.new(
        user_input_employee_percent: user_input_employee_percent,
        user_input_employer_percent: user_input_employer_percent
      ).filter
    end

    context 'when only employee contribution is higher than the period' do
      let(:user_input_employee_percent) { 4 }
      let(:user_input_employer_percent) { 1 }

      it 'does not exclude the period' do
        expect(filter.size).to eq(3)
      end

      it 'changes employee percentage for the low periods' do
        expect(filter[1].employee_percent).to eq(4)
      end

      it 'keeps the same employee percent for the higher period' do
        expect(filter.last.employee_percent).to eq(5)
      end
    end

    context 'when only employer contribution is higher than the period' do
      let(:user_input_employee_percent) { 1 }
      let(:user_input_employer_percent) { 4.5 }

      it 'does not exclude the period' do
        expect(filter.size).to eq(3)
      end

      it 'changes employer percentage for the low periods' do
        expect(filter[1].employer_percent).to eq(4.5)
      end

      it 'keeps the same employer percent for the higher period' do
        expect(filter.last.employer_percent).to eq(5)
      end
    end

    context 'when period percent is equal to user percent' do
      let(:user_input_employee_percent) { 3 }
      let(:user_input_employer_percent) { 4 }

      it 'excludes contribution period which is equal to the contributions' do
        expect(filter.size).to eq(2)
      end
    end

    context 'when contribution periods are less than user percents' do
      context 'when one period is less than user percents' do
        let(:user_input_employee_percent) { 4 }
        let(:user_input_employer_percent) { 5 }

        it 'excludes lower contribution period' do
          expect(filter.size).to eq(2)
        end
      end

      context 'when two periods is less than user percents' do
        let(:user_input_employee_percent) { 10 }
        let(:user_input_employer_percent) { 10 }

        it 'excludes lower contribution periods' do
          expect(filter.size).to eq(1)
        end
      end
    end
  end
end
