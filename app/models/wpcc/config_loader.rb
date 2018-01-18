module Wpcc
  class ConfigLoader
    def self.load(filename)
      hash = YAML.load_file(Wpcc::Engine.root.join('config', "#{filename}.yml"))

      HashWithIndifferentAccess.new(hash).freeze
    end
  end
end
