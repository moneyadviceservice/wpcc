RSpec.describe Wpcc::SalaryMessage do
  subject do
    described_class.new(
      salary: @salary,
      salary_frequency: salary_frequency,
      message: message
    )
  end

  describe '#tax_relief_warning?' do
    context 'message is set to tax_relief_warning' do
      let(:message) { :tax_relief_warning }

      context 'annual rate' do
        let(:salary_frequency) { 'year' }

        context 'salary below threshold' do
          it 'returns true' do
            @salary = 6_000
            expect(subject.tax_relief_warning?).to be_truthy
          end
        end

        context 'salary equal to threshold' do
          it 'returns false' do
            @salary = 11_500
            expect(subject.tax_relief_warning?).to be_falsey
          end
        end

        context 'salary above the threshold' do
          it 'returns false' do
            @salary = 16_700
            expect(subject.tax_relief_warning?).to be_falsey
          end
        end
      end

      context 'monthly rate' do
        let(:salary_frequency) { 'month' }

        context 'salary below threshold' do
          it 'returns true' do
            @salary = 900
            expect(subject.tax_relief_warning?).to be_truthy
          end
        end

        context 'salary below threshold' do
          it 'returns false' do
            @salary = 958.33
            expect(subject.tax_relief_warning?).to be_falsey
          end
        end

        context 'salary above the threshold' do
          it 'returns false' do
            @salary = 1_000
            expect(subject.tax_relief_warning?).to be_falsey
          end
        end
      end

      context 'fortnightly rate' do
        let(:salary_frequency) { 'fourweeks' }

        context 'salary below threshold' do
          it 'returns true' do
            @salary = 700
            expect(subject.tax_relief_warning?).to be_truthy
          end
        end

        context 'salary equal to threshold' do
          it 'returns false' do
            @salary = 884.61
            expect(subject.tax_relief_warning?).to be_falsey
          end
        end

        context 'salary above the threshold' do
          it 'returns false' do
            @salary = 1_000
            expect(subject.tax_relief_warning?).to be_falsey
          end
        end
      end

      context 'weekly rate' do
        let(:salary_frequency) { 'week' }

        context 'salary below threshold' do
          it 'returns true' do
            @salary = 100
            expect(subject.tax_relief_warning?).to be_truthy
          end
        end

        context 'salary equal to threshold' do
          it 'returns false' do
            @salary = 221.15
            expect(subject.tax_relief_warning?).to be_falsey
          end
        end

        context 'salary above the threshold' do
          it 'returns false' do
            @salary = 300
            expect(subject.tax_relief_warning?).to be_falsey
          end
        end
      end
    end

    context 'message is NOT set to tax_relief_warning' do
      let(:message) { :manually_opt_in }
      let(:salary_frequency) { 'whatever' }

      it 'returns false' do
        expect(subject.tax_relief_warning?).to be_falsey
      end
    end
  end
end
