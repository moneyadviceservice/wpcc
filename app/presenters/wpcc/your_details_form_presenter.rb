module Wpcc
  class YourDetailsFormPresenter < Presenter
    def error_class(attribute)
      object.errors[attribute].any? ? 'form__row--is-errored' : nil
    end

    def activate_disabled_callout
      if disable_minimum_contribution_option?
        'details__callout--active'
      else
        'details__callout--inactive'
      end
    end

    private

    def disable_minimum_contribution_option?
      errors.key?(:contribution_preference)
    end
  end
end
