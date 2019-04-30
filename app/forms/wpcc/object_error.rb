module Wpcc
  class ObjectError < Dough::Forms::ObjectError
    AGE_I18N_KEY =
      'activemodel.errors.models.wpcc/your_details_form.attributes.age'.freeze

    # rubocop:disable Metrics/LineLength
    CONTRIBUTION_I18N_KEY =
      'activemodel.errors.models.wpcc/your_contributions_form.attributes.employee_percent'.freeze
    # rubocop:enable Metrics/LineLength

    MESSAGES = [
      I18n.t("#{AGE_I18N_KEY}.greater_than_or_equal_to"),
      I18n.t("#{AGE_I18N_KEY}.less_than_or_equal_to"),
      I18n.t("#{CONTRIBUTION_I18N_KEY}.minimum_combined_contribution")
    ].freeze

    def full_message
      if age_error || employee_percent_error
        message
      else
        super
      end
    end

    private

    def age_error
      field_name == :age && message.in?(MESSAGES)
    end

    def employee_percent_error
      field_name == :employee_percent && message.in?(MESSAGES)
    end
  end
end
