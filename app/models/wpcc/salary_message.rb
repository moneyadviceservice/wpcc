module Wpcc
  class SalaryMessage
    include ActiveModel::Model
    attr_accessor :salary, :salary_frequency, :message

    OPT_IN_SALARY_LOWER_LIMIT = 5_876
    OPT_IN_SALARY_UPPER_LIMIT = 10_000

    def manually_opt_in_message?
      message == :manually_opt_in && manually_opt_in?
    end

    private

    def manually_opt_in?
      salary >= OPT_IN_SALARY_LOWER_LIMIT && salary <= OPT_IN_SALARY_UPPER_LIMIT
    end
  end
end
