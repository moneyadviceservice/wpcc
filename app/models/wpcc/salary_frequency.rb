module Wpcc
  class SalaryFrequency
    include ActiveModel::Model
    attr_accessor :params_salary_frequency, :session_salary_frequency

    DEFAULT_SALARY_FREQUENCIES = Hash[
      Wpcc::YourDetailsForm::SALARY_FREQUENCIES.map { |e| [e, e] }
    ].tap do |hash|
      hash['year'] = 'month'
    end

    def initialize(attributes)
      @converter = SalaryFrequencyConverter
      super(attributes)
    end

    def to_i
      @converter.convert(to_s)
    end

    def to_s
      return params_salary_frequency if params_salary_frequency.present?

      DEFAULT_SALARY_FREQUENCIES[session_salary_frequency]
    end
  end
end
