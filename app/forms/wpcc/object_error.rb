module Wpcc
  class ObjectError < Dough::Forms::ObjectError
    AGE_I18N_KEY =
      'activemodel.errors.models.wpcc/your_details_form.attributes.age'.freeze
    MESSAGES = [
      I18n.t("#{AGE_I18N_KEY}.greater_than_or_equal_to"),
      I18n.t("#{AGE_I18N_KEY}.less_than")
    ].freeze

    def full_message
      if field_name == :age && message.in?(MESSAGES)
        message
      else
        super
      end
    end
  end
end
