require 'active_model'

module Wpcc
  class YourContributionsForm
    include ActiveModel::Model

    attr_accessor :employee_contribution, :employer_contribution

    validates :employee_contribution, inclusion: { in: 0..100 }
    validates :employer_contribution, inclusion: { in: 0..100 }

    def initialize
    end

  end
end
