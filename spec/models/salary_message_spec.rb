RSpec.describe Wpcc::SalaryMessage do
  subject do
    described_class.new(
      salary: @salary,
      salary_frequency: 'per whatever',
      text: :text
    )
  end

  describe '#manually_opt_in?' do
    context 'salary is within the range requiring manually opting in' do
      it 'returns true' do
        @salary = 5_876

        expect(subject).to be_manually_opt_in
      end
    end

    context 'salary is above the range requiring manually opting in' do
      it 'returns false' do
        @salary = 10_001

        expect(subject).to_not be_manually_opt_in
      end
    end

    context 'salary is below the range requiring manually opting in' do
      it 'returns false' do
        @salary = 5_875

        expect(subject).to_not be_manually_opt_in
      end
    end
  end
end
