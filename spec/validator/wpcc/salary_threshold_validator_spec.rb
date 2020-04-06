RSpec.describe Wpcc::SalaryThresholdValidator do
  describe 'LOW_SALARY_THRESHOLDS' do
    it 'returns salary frequency with their upper limits' do
      expect(Wpcc::SalaryThresholdValidator::LOW_SALARY_THRESHOLDS).to eq(
        'year' => 6240,
        'month' => 520,
        'fourweeks' => 480,
        'week' => 120
      )
    end
  end
end
