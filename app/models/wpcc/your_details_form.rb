module Wpcc
  class YourDetailsForm
    extend Wpcc::SalaryThreshold
    include ActiveModel::Model

    attr_accessor :age, :gender, :salary
    attr_accessor :salary_frequency, :contribution_preference

    GENDERS = %w[male female].freeze
    SALARY_FREQUENCIES = load_config(file: 'salary_threshold').keys.map(&:to_s)
    CONTRIBUTIONS = %w[full minimum].freeze

    validates :age, presence: true
    validates :gender, inclusion: { in: GENDERS }
    validates :salary, numericality: { greater_than: 0 }
    validates :salary_frequency, inclusion: { in: SALARY_FREQUENCIES }
    validates :contribution_preference, inclusion: { in: CONTRIBUTIONS }
    validates_with Wpcc::SalaryThresholdValidator
  end
end
