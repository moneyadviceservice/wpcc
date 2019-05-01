module Wpcc
  class YourContributionsForm
    include ActiveModel::Model

    attr_accessor :employee_percent, :employer_percent

    validates :employee_percent,
              numericality: {
                greater_than_or_equal_to: 0, less_than_or_equal_to: 100
              }
    validates :employer_percent,
              numericality: {
                greater_than_or_equal_to: 3, less_than_or_equal_to: 100
              }
    validates_with Wpcc::ContributionsValidator

    def employee_percent
      @employee_percent.to_f
    end

    def employer_percent
      @employer_percent.to_f
    end
  end
end
