module Wpcc
  class Presenter < SimpleDelegator
    delegate :t, :number_to_currency, :session, to: :view_context

    attr_reader :object, :view_context

    def initialize(object, args = {})
      super(object)
      @view_context = args[:view_context]
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
        Wpcc::ContributionCalculator::THRESHOLDS['upper'],
        precision: 0
      )
    end

    def formatted_lower_earnings
      formatted_currency(
        Wpcc::ContributionCalculator::THRESHOLDS['lower'],
        precision: 0
      )
    end

    def formatted_currency(currency_value, precision: 2)
      number_to_currency(currency_value, unit: '£', precision: precision)
    end

    def popup_tip_content_options(text, classname)
      {
        text: text,
        classname: classname,
        tooltip_hide: t('wpcc.tooltip_hide')
      }
    end

    private

    def text_for(option, value)
      t("wpcc.details.options.#{option}.#{value}")
    end

    def frequency_adjective(frequency)
      @converter.adjectives[I18n.locale.to_s][frequency]
    end
  end
end
