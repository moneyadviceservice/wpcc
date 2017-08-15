module Wpcc
  class YourContributionsSessionVerifier < ::Wpcc::SessionVerifier
    SESSION_KEYS =
      %i[
        age
        gender
        salary
        salary_frequency
        contribution_preference
      ].freeze

    def session_keys
      SESSION_KEYS
    end
  end
end
