module Wpcc
  class YourContributionsForm
    include ActiveModel::Model

    attr_accessor :employee_percent, :employer_percent

    validates :employee_percent, inclusion: { in: 0..100 }
    validates :employer_percent, inclusion: { in: 0..100 }

    def employee_percent
      @employee_percent.to_i
    end

    def employer_percent
      @employer_percent.to_i
    end
  end
end
