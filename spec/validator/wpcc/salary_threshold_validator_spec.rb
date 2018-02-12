RSpec.describe Wpcc::SalaryThresholdValidator do
  describe 'LOW_SALARY_THRESHOLDS' do
    it 'returns salary frequency with their upper limits' do
      expect(Wpcc::SalaryThresholdValidator::LOW_SALARY_THRESHOLDS).to eq(
        'year' => 6032.0,
        'month' => 503.0,
        'fourweeks' => 464.0,
        'week' => 116.0
      )
    end
  end
end
