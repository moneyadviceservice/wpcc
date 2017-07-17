module Wpcc
  class YourDetailsForm
    include ActiveModel::Model

    attr_accessor :age, :gender, :salary
    attr_accessor :salary_frequency, :contribution_preference

    GENDERS = %w[male female].freeze
    SALARY_FREQUENCIES = %w[year month fourweeks week].freeze
    SALARY_THRESHOLDS  = [5876.00, 489.67, 452.00, 113.00].freeze
    CONTRIBUTIONS = %w[full minimum].freeze
    LOW_SALARY_THRESHOLDS = SALARY_FREQUENCIES.zip(SALARY_THRESHOLDS).to_h

    validates :age, presence: true
    validates :gender, inclusion: { in: GENDERS }
    validates :salary, numericality: { only_integer: true, greater_than: 0 }
    validates :salary_frequency, inclusion: { in: SALARY_FREQUENCIES }
    validates :contribution_preference, inclusion: { in: CONTRIBUTIONS }

    # Custom validation
    validate :low_salary_threshold

    def low_salary_threshold
      return if !SALARY_FREQUENCIES.include?(salary_frequency)

      if (salary.to_f < LOW_SALARY_THRESHOLDS[salary_frequency]) &&
         (contribution_preference == 'minimum')
        errors.add(:contribution_preference, 'salary is below threshold')
      end
    end
  end
end
