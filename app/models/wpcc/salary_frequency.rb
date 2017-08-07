module Wpcc
  class SalaryFrequency
    include ActiveModel::Model
    attr_accessor :params_salary_frequency, :session_salary_frequency

    def initialize(attributes)
      @converter = SalaryFrequencyConverter
      super(attributes)
    end

    def to_i
      @converter.convert(to_s)
    end

    def to_s
      return params_salary_frequency if params_salary_frequency.present?

      default_salary_frequency[session_salary_frequency]
    end

    private

    def default_salary_frequency
      Hash[
        Wpcc::YourDetailsForm::SALARY_FREQUENCIES.map do |elem|
          [elem, elem == 'year' ? 'month' : elem]
        end
      ]
    end
  end
end
