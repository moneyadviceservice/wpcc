RSpec.describe Wpcc::PeriodPercentsMapper do
  describe '#map' do
    let(:user_input_employee_percent) { 1 }
    let(:user_input_employer_percent) { 1 }

    subject do
      described_class.new(
        user_input_employee_percent: user_input_employee_percent,
        user_input_employer_percent: user_input_employer_percent
      )
    end

    it 'returns a mapped Period object' do
      expect(Wpcc::Period).to receive(:new).exactly(1).times
      subject.map
    end
  end
end
