module Wpcc
  class SalaryThresholdValidator < ActiveModel::Validator
    extend WpccConfig

    LOW_SALARY_THRESHOLDS = opt_in_thresholds_by_frequency['lower']

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
