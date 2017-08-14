module Wpcc
  class YourContributionsVerifySession < ::Wpcc::BaseFilter
    YOUR_DETAILS_KEYS =
      %i[
        age
        gender
        salary
        salary_frequency
        contribution_preference
      ].freeze
    def filter
      redirect_to wpcc_root_path if YOUR_DETAILS_KEYS.any? do |key|
        session[key].blank?
      end
    end
  end
end
