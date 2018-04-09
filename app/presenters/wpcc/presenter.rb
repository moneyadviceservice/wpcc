module Wpcc
  class Presenter < SimpleDelegator
    include Wpcc::WpccConfig
    delegate :t, :number_to_currency, :session, to: :view_context

    attr_reader :object, :view_context

    def initialize(object, view_context: nil)
      super(object)
      @view_context = view_context
      @object = object
      @converter = Wpcc::SalaryFrequencyConverter
    end

    def salary_frequency_options
      @converter::SALARY_FREQUENCIES
        .map do |frequency, frequency_number|
          [
            text_for('salary_frequency', frequency),
            frequency,
            data: {
              unit_converter: frequency_number,
              frequency_adjective: frequency_adjective(frequency)
            }
          ]
        end
    end

    def formatted_upper_earnings
      formatted_currency(
        salary_threshold(:upper),
        precision: 0
      )
    end

    def formatted_lower_earnings
      formatted_currency(
        salary_threshold(:lower),
        precision: 0
      )
    end

    def formatted_currency(currency_value, precision: 2)
      number_to_currency(currency_value, unit: '£', precision: precision)
    end

    private

    def text_for(option, value)
      t("wpcc.details.options.#{option}.#{value}")
    end

    def frequency_adjective(frequency)
      t("wpcc.frequency_adjectives.#{frequency}")
    end
  end
end
