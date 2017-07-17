module Wpcc
  module YourDetailsFormHelper
    def disable_minimum_contribution_option?
      @your_details_form.errors.keys.include?(:contribution_preference)
    end
  end
end
