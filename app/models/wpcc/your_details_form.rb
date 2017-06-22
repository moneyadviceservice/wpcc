require 'active_model'

module Wpcc
  class YourDetailsForm
    include ActiveModel::Model

    attr_accessor :age, :gender, :salary

    GENDERS = %w[m f].freeze

    validates :age, presence: true
    validates :gender, inclusion: { in: GENDERS }
    validates :salary, numericality: { only_integer: true, greater_than: 0 }
  end
end
