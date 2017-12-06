module Wpcc
  class YourDetailsFormPresenter < Presenter
    def gender_options
      Wpcc::YourDetailsForm::GENDERS.map do |gender|
        [text_for('gender', gender), gender.downcase]
      end
    end

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

    def popup_tip_content_options(text)
      {
        text: text,
        classname: 'details__helper',
        tooltip_hide: t('wpcc.tooltip_hide')
      }
    end

    private

    def disable_minimum_contribution_option?
      errors.keys.include?(:contribution_preference)
    end
  end
end
