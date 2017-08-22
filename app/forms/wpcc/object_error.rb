module Wpcc
  class ObjectError < Dough::Forms::ObjectError
    def show_message_without_field_name?
      [:age].include? field_name
    end
  end
end
