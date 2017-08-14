module Wpcc
  class YourResultsVerifySession < ::Wpcc::BaseFilter
    YOUR_CONTRIBUTION_KEYS =
      %i[
        eligible_salary
        employee_percent
        employer_percent
      ].freeze
    def filter
      redirect_to wpcc_root_path if YOUR_CONTRIBUTION_KEYS.any? do |key|
        session[key].blank?
      end
    end
  end
end
