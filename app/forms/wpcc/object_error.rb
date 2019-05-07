module Wpcc
  class ObjectError < Dough::Forms::ObjectError
    AGE_I18N_KEY =
      'activemodel.errors.models.wpcc/your_details_form.attributes.age'.freeze

    MESSAGES = [
      I18n.t("#{AGE_I18N_KEY}.greater_than_or_equal_to"),
      I18n.t("#{AGE_I18N_KEY}.less_than_or_equal_to")
    ].freeze

    def full_message
      if field_name == :age && message.in?(MESSAGES)
        message
      else
        super
      end
    end

    # override this Dough method to remove the field name
    # from the form error message, for example
    # "Total contribution must be at least 8%"
    # instead of
    # "Base total contribution must be at least 8%"
    def show_message_without_field_name?
      field_name == :base
    end
  end
end
