module Wpcc
  class YourDetailsFormPresenter < SimpleDelegator
    def initialize(args = {})
      super(args[:your_details_form])
      @translator = args[:translator]
    end

    def gender_options
      Wpcc::YourDetailsForm::GENDERS.map do |gender|
        text_for('gender', gender)
      end
    end

    def salary_frequency_options
      Wpcc::YourDetailsForm::SALARY_FREQUENCIES.map do |frequency|
        text_for('salary_frequency', frequency)
      end
    end

    private

    attr_reader :translator

    def text_for(option, value)
      translator.call("wpcc.details.options.#{option}.#{value}")
    end
  end
end