module Wpcc
  module SalaryThreshold
    extend ActiveSupport::Concern

    def load_config(file:)
      YAML.load_file(Wpcc::Engine.root.join('config', "#{file}.yml"))
    end
  end
end
