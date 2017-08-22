module Wpcc
  class Presenter < SimpleDelegator
    delegate :t, :number_to_currency, :session, to: :view_context

    attr_reader :object, :view_context

    def initialize(object, args = {})
      super(object)
      @view_context = args[:view_context]
      @object = object
    end

    def salary_frequency_options
      Wpcc::SalaryFrequencyConverter::SALARY_FREQUENCIES
        .map do |frequency, frequency_number|
          [
            text_for('salary_frequency', frequency),
            frequency,
            data: { unit_converter: frequency_number }
          ]
        end
    end

    def formatted_currency(currency_value, precision: 2)
      number_to_currency(currency_value, unit: '£', precision: precision)
    end

    private

    def text_for(option, value)
      t("wpcc.details.options.#{option}.#{value}")
    end
  end
end
