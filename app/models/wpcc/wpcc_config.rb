module Wpcc
  module WpccConfig
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

    def salary_threshold(limit)
      config['salary_thresholds'][limit]
    end

    def current_min_contribution_percentage_for(contributor, limit)
      min_contribution_percentages_by_period[current_period][contributor][limit]
    end

    def min_contribution_percentages_by_period
      config['contribution_percentages']['legal_minimums_by_period']
    end

    private

    def current_period
      'april_2018_march_2019'
    end
  end
end
