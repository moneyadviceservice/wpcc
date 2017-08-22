module Wpcc
  class Builder < Dough::Forms::Builder
    def object_error_class
      ::Wpcc::ObjectError
    end
  end
end
