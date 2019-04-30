module Wpcc
  class ContributionsValidator < ActiveModel::Validator
    extend WpccConfig

    COMBINED_MINIMUM = minimum_combined_contribution

    def validate(record)
      record.errors[:base] << I18n.t('minimum_combined_contribution') if
        record.employee_percent + record.employer_percent < COMBINED_MINIMUM
    end
  end
end
