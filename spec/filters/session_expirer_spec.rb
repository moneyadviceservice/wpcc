RSpec.describe Wpcc::SessionExpirer do
  let(:controller) { double(session: session) }
  let(:session) do
    {
      'age' => 34,
      'salary' => 30_000,
      'salary_frequency' => 'month',
      'contribution_preference' => 'full',
      'eligible_salary' => 19_524,
      'employee_percent' => 1,
      'employer_percent' => 2
    }
  end

  describe '#filter' do
    subject(:filter) { described_class.new(controller).filter }
    after { Timecop.return }
    before { session[:wpcc_expires_at] = 30.minutes.from_now }

    context 'when session has NOT expired' do
      before do
        Timecop.travel(10.minutes.from_now)
      end

      it 'keeps the same session' do
        filter
        expect(session).to eq(session)
      end
    end

    context 'when session has expired' do
      before do
        Timecop.travel(30.minutes.from_now)
      end

      it 'expires session' do
        filter
        expect(session.except(:wpcc_expires_at)).to eq(
          'age' => nil,
          'salary' => nil,
          'salary_frequency' => nil,
          'contribution_preference' => nil,
          'eligible_salary' => nil,
          'employee_percent' => nil,
          'employer_percent' => nil
        )
      end
    end

    context 'when updating the session expire time' do
      it 'sets session expire time' do
        filter
        expires_at = Time.zone.at(session[:wpcc_expires_at].to_i)
        expect(expires_at).to eq(Time.zone.at(30.minutes.from_now.to_i))
      end
    end
  end
end
