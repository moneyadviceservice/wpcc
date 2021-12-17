module Wpcc
  class YourContributionsSessionVerifier < ::Wpcc::SessionVerifier
    SESSION_KEYS =
      %i[
        age
        salary
        salary_frequency
        contribution_preference
      ].freeze

    def session_keys
      SESSION_KEYS
    end
  end
end
