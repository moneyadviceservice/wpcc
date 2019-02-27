RSpec.describe Wpcc::SalaryThresholdValidator do
  describe 'LOW_SALARY_THRESHOLDS' do
    it 'returns salary frequency with their upper limits' do
      expect(Wpcc::SalaryThresholdValidator::LOW_SALARY_THRESHOLDS).to eq(
        'year' => 6136,
        'month' => 512,
        'fourweeks' => 472,
        'week' => 118
      )
    end
  end
end
