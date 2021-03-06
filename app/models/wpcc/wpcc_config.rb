module Wpcc
  module WpccConfig
    PERIOD = 'current'.freeze

    def config
      hash = YAML.load_file(Wpcc::Engine.root.join('config', 'config.yml'))

      HashWithIndifferentAccess.new(hash).freeze
    end

    def frequency_conversions
      config['frequency_conversions']
    end

    def opt_in_thresholds_by_frequency
      config['frequency_conversions']['opt_in_thresholds_by_frequency']
    end

    def salary_threshold(bracket)
      config['salary_thresholds'][bracket]
    end

    def current_min_contribution_percentage_for(contributor, limit)
      min_contribution_percentages[PERIOD][contributor][limit]
    end

    def min_contribution_percentages
      config['contribution_percentages']
    end

    def minimum_combined_contribution
      config['contribution_percentages']['current']['combined_minimum']
    end
  end
end
