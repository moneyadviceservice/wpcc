describe Wpcc::PeriodContributionCalculator, type: :model do
  let(:period_contribution_calculator) do
    described_class.new(
      eligible_salary,
      salary_frequency,
      period_args
    )
  end

  let(:period_args) do
    {
      name: 'some period',
      employee_percent: employee_percent,
      employer_percent: employer_percent,
      tax_relief_percent: 20
    }
  end

  describe '#contribution' do
    let(:period_contribution) { period_contribution_calculator.contribution }

    context 'for yearly frequency' do
      let(:eligible_salary) { 39_124 }
      let(:salary_frequency) { 1 }
      let(:employee_percent) { 1 }
      let(:employer_percent) { 1 }

      it 'knows which period its calculating contributions' do
        expect(period_contribution.name).to eq('some period')
      end

      it 'returns yearly employee contribution' do
        expect(period_contribution.employee_contribution).to eq(391.24)
      end

      it 'returns yearly employer contribution' do
        expect(period_contribution.employer_contribution).to eq(391.24)
      end

      it 'returns yearly total contribution' do
        expect(period_contribution.total_contributions).to eq(782.48)
      end

      it 'returns employee tax relief' do
        expect(period_contribution.tax_relief).to eq(78.25)
      end
    end

    context 'for monthly frequency' do
      let(:eligible_salary) { 12_124 }
      let(:salary_frequency) { 12 }
      let(:employee_percent) { 3 }
      let(:employer_percent) { 2 }

      it 'returns monthly employee contribution' do
        expect(period_contribution.employee_contribution).to eq(30.31)
      end

      it 'returns monthly employer contribution' do
        expect(period_contribution.employer_contribution).to eq(20.21)
      end

      it 'returns monthly total contribution' do
        expect(period_contribution.total_contributions).to eq(50.52)
      end

      it 'returns employee tax relief' do
        expect(period_contribution.tax_relief).to eq(6.06)
      end
    end

    context 'for 4-weekly frequency' do
      let(:eligible_salary) { 18_824 }
      let(:salary_frequency) { 13 }
      let(:employee_percent) { 5 }
      let(:employer_percent) { 4 }

      it 'returns 4-weekly employee contribution' do
        expect(period_contribution.employee_contribution).to eq(72.40)
      end

      it 'returns 4-weekly employer contribution' do
        expect(period_contribution.employer_contribution).to eq(57.92)
      end

      it 'returns 4-weekly total contribution' do
        expect(period_contribution.total_contributions).to eq(130.32)
      end

      it 'returns the employee tax relief' do
        expect(period_contribution.tax_relief).to eq(14.48)
      end
    end

    context 'for weekly frequency' do
      let(:eligible_salary) { 14_924 }
      let(:salary_frequency) { 52 }
      let(:employee_percent) { 3 }
      let(:employer_percent) { 2 }

      it 'returns weekly employee contribution' do
        expect(period_contribution.employee_contribution).to eq(8.61)
      end

      it 'returns weekly employer contribution' do
        expect(period_contribution.employer_contribution).to eq(5.74)
      end

      it 'returns weekly total contribution' do
        expect(period_contribution.total_contributions).to eq(14.35)
      end

      it 'returns employee tax relief' do
        expect(period_contribution.tax_relief).to eq(1.72)
      end
    end
  end
end
