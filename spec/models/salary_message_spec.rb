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
        let(:salary) { 11_500 }

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

      context 'salary below threshold' do
        let(:salary) { 958.33 }

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

    context 'four weekly rate' do
      let(:salary_frequency) { 'fourweeks' }

      context 'salary below threshold' do
        let(:salary) { 700 }

        it 'returns true' do
          expect(subject).to be_salary_below_tax_relief_threshold
        end
      end

      context 'salary equal to threshold' do
        let(:salary) { 884.61 }

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
        let(:salary) { 221.15 }

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
    let(:salary_frequency) { 'whatever' }

    context 'salary is within the range requiring manually opting in' do
      let(:salary) { 5_876 }

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
      let(:salary) { 5_875 }

      it 'returns false' do
        expect(subject).to_not be_manually_opt_in
      end
    end
  end
end
