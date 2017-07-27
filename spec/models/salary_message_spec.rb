RSpec.describe Wpcc::SalaryMessage do
  subject do
    described_class.new(
      salary: @salary,
      salary_frequency: 'per whatever',
      message: message
    )
  end

  describe '#manually_opt_in_message?' do
    context 'message is set to manually_opt_in' do
      let(:message) { :manually_opt_in }

      it 'returns true if salary outside auto enrolment range' do
        @salary = 5_876

        expect(subject.manually_opt_in_message?).to eq(true)
      end

      it 'returns false if salary is above auto enrolment range' do
        @salary = 10_001

        expect(subject.manually_opt_in_message?).to eq(false)
      end

      it 'returns false if salary is below auto enrolment range' do
        @salary = 5_875

        expect(subject.manually_opt_in_message?).to eq(false)
      end
    end

    context 'message is NOT set to manually_opt_in' do
      let(:message) { :not_manually_opt_in }

      it 'returns false' do
        expect(subject.manually_opt_in_message?).to eq(false)
      end
    end
  end
end
