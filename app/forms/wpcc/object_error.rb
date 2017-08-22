module Wpcc
  class ObjectError < Dough::Forms::ObjectError
    MESSAGES = [
      I18n.t('activemodel.errors.models.wpcc/your_details_form.attributes.age.greater_than_or_equal_to'),
      I18n.t('activemodel.errors.models.wpcc/your_details_form.attributes.age.less_than')
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
