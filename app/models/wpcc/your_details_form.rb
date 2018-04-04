module Wpcc
  class YourDetailsForm
    include ActiveModel::Model
    extend WpccConfig

    attr_accessor :age, :gender, :salary
    attr_accessor :salary_frequency, :contribution_preference

    AGE = { minimum: 16, maximum: 74 }.freeze
    GENDERS = %w[male female].freeze
    CONTRIBUTIONS = %w[full minimum].freeze
    SALARY_FREQUENCIES = frequency_conversions['salary_frequencies'].keys

    validates :age, presence: true
    validates :age, numericality: {
      greater_than_or_equal_to: AGE[:minimum],
      less_than_or_equal_to: AGE[:maximum]
    }
    validates :gender, inclusion: { in: GENDERS }
    validates :salary, numericality: { greater_than: 0 }
    validates :salary_frequency, inclusion: { in: SALARY_FREQUENCIES }
    validates :contribution_preference, inclusion: { in: CONTRIBUTIONS }
    validates_with Wpcc::SalaryThresholdValidator

    def contribution_preference
      return 'full' if minimum_contribution? && contribution_errors?

      @contribution_preference.blank? ? 'minimum' : @contribution_preference
    end

    private

    def minimum_contribution?
      @contribution_preference == 'minimum'
    end

    def contribution_errors?
      errors.key?(:contribution_preference)
    end
  end
end
