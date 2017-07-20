RSpec.describe Wpcc::SalaryThresholdValidator do
  describe 'LOW_SALARY_THRESHOLDS' do
    it 'returns salary frequency with their upper limits' do
      expect(Wpcc::SalaryThresholdValidator::LOW_SALARY_THRESHOLDS).to eq(
        'year' => 5876.0,
        'month' => 489.67,
        'fourweeks' => 452.0,
        'week' => 113.0
      )
    end
  end
end
