require 'active_model'

module Wpcc
  class YourDetailsForm
    include ActiveModel::Model

    attr_accessor :age, :gender, :salary, :salary_frequency, :contribution

    GENDERS = %w[male female].freeze
    SALARY_FREQUENCIES = %w[yearly monthly four_weekly weekly].freeze
    CONTRIBUTIONS = %w[full minimum].freeze

    validates :age, presence: true
    validates :gender, inclusion: { in: GENDERS }
    validates :salary, numericality: { only_integer: true, greater_than: 0 }
    validates :salary_frequency, inclusion: { in: SALARY_FREQUENCIES }
    validates :contribution, inclusion: { in: CONTRIBUTIONS }
  end
end
