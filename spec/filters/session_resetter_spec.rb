RSpec.describe Wpcc::SessionResetter do
  describe '#filter' do
    subject(:filter) { described_class.new(controller).filter }
    let(:controller) { double(session: session) }
    let(:session) do
      {
        'age' => 34,
        'salary' => 30_000,
        'gender' => 'female',
        'salary_frequency' => 'month',
        'contribution_preference' => 'full',
        'eligible_salary' => 19_524,
        'employee_percent' => 1,
        'employer_percent' => 2
      }
    end

    it 'expires the session and redirects to Step 1' do
      expect(controller).to receive(:new_your_detail_path)
      expect(controller).to receive(:redirect_to)

      filter

      expect(session.except(:wpcc_expires_at)).to eq(
        'age' => nil,
        'salary' => nil,
        'gender' => nil,
        'salary_frequency' => nil,
        'contribution_preference' => nil,
        'eligible_salary' => nil,
        'employee_percent' => nil,
        'employer_percent' => nil
      )
    end
  end
end
