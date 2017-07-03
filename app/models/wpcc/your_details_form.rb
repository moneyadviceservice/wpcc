require 'active_model'

module Wpcc
  class YourDetailsForm
    include ActiveModel::Model

    attr_accessor :age, :gender, :salary
    attr_accessor :salary_frequency, :employer_contribution

    GENDERS = %w[male female].freeze
    SALARY_FREQUENCIES = %w[year month fourweeks week].freeze
    CONTRIBUTIONS = %w[full minimum].freeze

    validates :age, presence: true
    validates :gender, inclusion: { in: GENDERS }
    validates :salary, numericality: { only_integer: true, greater_than: 0 }
    validates :salary_frequency, inclusion: { in: SALARY_FREQUENCIES }
    validates :employer_contribution, inclusion: { in: CONTRIBUTIONS }
  end
end
