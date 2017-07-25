RSpec.describe Wpcc::ContributionPeriods do
  subject(:contribution_periods) do
    described_class.new(
      employee_percent: employee_percent,
      employer_percent: employer_percent
    )
  end

  describe '#above_user_contributions' do
    subject(:above_user_contributions) do
      contribution_periods.above_user_contributions
    end

    let(:periods) do
      {
        current: {
          tax_relief_percent: 20
        },
        some_period: {
          tax_relief_percent: 20,
          employee_percent: 3,
          employer_percent: 4
        },
        period_onwards: {
          tax_relief_percent: 20,
          employee_percent: 5,
          employer_percent: 4
        }
      }
    end

    before do
      allow(contribution_periods)
        .to receive(:periods)
        .and_return(periods)
    end

    context 'when contribution periods less than user percents' do
      context 'when one period is less than user percents' do
        let(:employee_percent) { 3 }
        let(:employer_percent) { 4 }

        it 'excludes lower contribution period' do
          expect(above_user_contributions.size).to eq(2)
        end
      end

      context 'when two periods is less than user percents' do
        let(:employee_percent) { 10 }
        let(:employer_percent) { 10 }

        it 'excludes lower contribution periods' do
          expect(above_user_contributions.size).to eq(1)
        end
      end
    end
  end
end
