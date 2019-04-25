module Wpcc
  class ContributionsValidator < ActiveModel::Validator
    extend WpccConfig

    COMBINED_MINIMUM = minimum_combined_contribution

    def validate(record)
      record.errors.add(:employer_percent) if
        record.employee_percent + record.employer_percent < COMBINED_MINIMUM
    end
  end
end
