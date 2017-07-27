module Wpcc
  class Percent
    def self.choose_highest(period_percent, user_percent)
      return user_percent if period_percent.blank?

      [period_percent, user_percent].max
    end
  end
end
