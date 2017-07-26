module Wpcc
  class Presenter < SimpleDelegator
    delegate :t, :number_to_currency, to: :view_context

    attr_reader :object, :view_context

    def initialize(object, args = {})
      super(object)
      @view_context = args[:view_context]
      @object = object
    end

    def salary_frequency_options
      Wpcc::YourDetailsForm::SALARY_FREQUENCIES.map do |frequency|
        [text_for('salary_frequency', frequency), frequency]
      end
    end

    private

    def text_for(option, value)
      t("wpcc.details.options.#{option}.#{value}")
    end
  end
end
