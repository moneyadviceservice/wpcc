module Wpcc
  class SalaryThresholdValidator < ActiveModel::Validator
    LOW_SALARY_THRESHOLDS =
      ::Wpcc::ConfigLoader.load('salary_threshold').stringify_keys

    def validate(record)
      record.errors.add(:contribution_preference) if
        salary_below_threshold?(record) && minimum_contribution?(record)
    end

    private

    def salary_below_threshold?(record)
      salary_threshold = LOW_SALARY_THRESHOLDS[record.salary_frequency]

      salary_threshold && record.salary.to_f < salary_threshold
    end

    def minimum_contribution?(record)
      record.contribution_preference == 'minimum'
    end
  end
end
