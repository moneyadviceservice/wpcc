module Wpcc
  class SalaryThresholdValidator < ActiveModel::Validator
    SALARY_THRESHOLDS  = [5876.00, 489.67, 452.00, 113.00].freeze
    SALARY_FREQUENCIES = %w[year month fourweeks week].freeze
    LOW_SALARY_THRESHOLDS = SALARY_FREQUENCIES.zip(SALARY_THRESHOLDS).to_h

    def validate(record)
      record.errors.add(:contribution_preference) if
        salary_below_threshold?(record) && minimum_contribution?(record)
    end

    def salary_below_threshold?(record)
      salary_threshold = LOW_SALARY_THRESHOLDS[record.salary_frequency]

      salary_threshold && record.salary.to_f < salary_threshold
    end

    def minimum_contribution?(record)
      record.contribution_preference == 'minimum'
    end
  end
end
