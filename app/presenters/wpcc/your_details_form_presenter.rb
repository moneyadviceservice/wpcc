module Wpcc
  class YourDetailsFormPresenter < Presenter
    def gender_options
      Wpcc::YourDetailsForm::GENDERS.map do |gender|
        [text_for('gender', gender), gender.downcase]
      end
    end

    def disabled_class
      disable_minimum_contribution_option? ? 'disabled' : nil
    end

    private

    def disable_minimum_contribution_option?
      errors.keys.include?(:contribution_preference)
    end
  end
end
