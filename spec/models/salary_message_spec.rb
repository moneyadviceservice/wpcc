RSpec.describe Wpcc::SalaryMessage do
  subject do
    described_class.new(
      salary: salary,
      salary_frequency: salary_frequency,
      text: :text
    )
  end

  describe '#salary_below_tax_relief_threshold?' do
    context 'annual rate' do
      let(:salary_frequency) { 'year' }

      context 'salary below threshold' do
        let(:salary) { 6_000 }
        it 'returns true' do
          expect(subject).to be_salary_below_tax_relief_threshold
        end
      end

      context 'salary equal to threshold' do
        let(:salary) { 12_500 }

        it 'returns false' do
          expect(subject).to_not be_salary_below_tax_relief_threshold
        end
      end

      context 'salary above the threshold' do
        let(:salary) { 16_700 }

        it 'returns false' do
          expect(subject).to_not be_salary_below_tax_relief_threshold
        end
      end
    end

    context 'monthly rate' do
      let(:salary_frequency) { 'month' }

      context 'salary below threshold' do
        let(:salary) { 900 }

        it 'returns true' do
          expect(subject).to be_salary_below_tax_relief_threshold
        end
      end

      context 'salary equal to threshold' do
        let(:salary) { 1_042 }

        it 'returns false' do
          expect(subject).to_not be_salary_below_tax_relief_threshold
        end
      end

      context 'salary above the threshold' do
        let(:salary) { 1_043 }

        it 'returns false' do
          expect(subject).to_not be_salary_below_tax_relief_threshold
        end
      end
    end

    context 'four weekly rate' do
      let(:salary_frequency) { 'fourweeks' }

      context 'salary below threshold' do
        let(:salary) { 700 }

        it 'returns true' do
          expect(subject).to be_salary_below_tax_relief_threshold
        end
      end

      context 'salary equal to threshold' do
        let(:salary) { 960 }

        it 'returns false' do
          expect(subject).to_not be_salary_below_tax_relief_threshold
        end
      end

      context 'salary above the threshold' do
        let(:salary) { 1_000 }

        it 'returns false' do
          expect(subject).to_not be_salary_below_tax_relief_threshold
        end
      end
    end

    context 'weekly rate' do
      let(:salary_frequency) { 'week' }

      context 'salary below threshold' do
        let(:salary) { 100 }

        it 'returns true' do
          expect(subject).to be_salary_below_tax_relief_threshold
        end
      end

      context 'salary equal to threshold' do
        let(:salary) { 240.00 }

        it 'returns false' do
          expect(subject).to_not be_salary_below_tax_relief_threshold
        end
      end

      context 'salary above the threshold' do
        let(:salary) { 300 }

        it 'returns false' do
          expect(subject).to_not be_salary_below_tax_relief_threshold
        end
      end
    end

    context 'salary_frequency is not recognised' do
      let(:salary_frequency) { 'whatever' }
      let(:salary) { 123.45 }

      it 'returns false' do
        expect(subject).to_not be_salary_below_tax_relief_threshold
      end
    end
  end

  describe '#manually_opt_in?' do
    context 'weekly rate'
    let(:salary_frequency) { 'year' }

    context 'salary is within the range requiring manually opting in' do
      let(:salary) { 6_244 }

      it 'returns true' do
        expect(subject).to be_manually_opt_in
      end
    end

    context 'salary is above the range requiring manually opting in' do
      let(:salary) { 10_001 }

      it 'returns false' do
        expect(subject).to_not be_manually_opt_in
      end
    end

    context 'salary is below the range requiring manually opting in' do
      let(:salary) { 6_031 }

      it 'returns false' do
        expect(subject).to_not be_manually_opt_in
      end
    end
  end

  describe '#salary_below_pension_limit?' do
    let(:salary_frequency) { 'year' }

    context 'salary is within the range of an automatic workplace pension' do
      let(:salary) { 6_244 }

      it 'returns false' do
        expect(subject).not_to be_salary_below_pension_limit
      end
    end

    context 'salary is above the range of an automatic workplace pension' do
      let(:salary) { 10_001 }

      it 'returns false' do
        expect(subject).not_to be_salary_below_pension_limit
      end
    end

    context 'salary is below the range of an automatic workplace pension' do
      let(:salary) { 6_000 }

      it 'returns true' do
        expect(subject).to be_salary_below_pension_limit
      end
    end
  end

  describe '#salary_near_pension_limit' do
    context 'yearly salary_frequency' do
      let(:salary_frequency) { 'year' }

      context 'salary is within the range of an automatic pension warning' do
        let(:salary) { 6_230 }
        it { is_expected.to be_salary_near_pension_limit }

        let(:salary) { 6_250 }
        it { is_expected.to be_salary_near_pension_limit }
      end

      context 'salary is outside the range of an automatic pension warning' do
        let(:salary) { 6_125 }
        it { is_expected.not_to be_salary_near_pension_limit }

        let(:salary) { 6_147 }
        it { is_expected.not_to be_salary_near_pension_limit }
      end
    end

    context 'weekly salary_frequency' do
      let(:salary_frequency) { 'week' }

      context 'salary is within the range of an automatic pension warning' do
        let(:salary) { 108 }
        it { is_expected.to be_salary_near_pension_limit }

        let(:salary) { 128 }
        it { is_expected.to be_salary_near_pension_limit }
      end

      context 'salary is outside the range of an automatic pension warning' do
        let(:salary) { 107 }
        it { is_expected.not_to be_salary_near_pension_limit }

        let(:salary) { 131 }
        it { is_expected.not_to be_salary_near_pension_limit }
      end
    end
  end

  describe '#salary_near_manual_opt_in_limit' do
    context 'yearly salary_frequency' do
      let(:salary_frequency) { 'year' }

      context 'salary is within the range of an automatic pension warning' do
        let(:salary) { 9_990 }
        it { is_expected.to be_salary_near_manual_opt_in_limit }

        let(:salary) { 10_010 }
        it { is_expected.to be_salary_near_manual_opt_in_limit }
      end

      context 'salary is outside the range of an automatic pension warning' do
        let(:salary) { 9_989 }
        it { is_expected.not_to be_salary_near_manual_opt_in_limit }

        let(:salary) { 10_011 }
        it { is_expected.not_to be_salary_near_manual_opt_in_limit }
      end
    end

    context 'weekly salary_frequency' do
      let(:salary_frequency) { 'week' }

      context 'salary is within the range of an automatic pension warning' do
        let(:salary) { 182 }
        it { is_expected.to be_salary_near_manual_opt_in_limit }

        let(:salary) { 202 }
        it { is_expected.to be_salary_near_manual_opt_in_limit }
      end

      context 'salary is outside the range of an automatic pension warning' do
        let(:salary) { 181 }
        it { is_expected.not_to be_salary_near_manual_opt_in_limit }

        let(:salary) { 203 }
        it { is_expected.not_to be_salary_near_manual_opt_in_limit }
      end
    end
  end
end
