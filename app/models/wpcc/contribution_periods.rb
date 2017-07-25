module Wpcc
  class ContributionPeriods
    include ActiveModel::Model
    attr_accessor :employee_percent, :employer_percent

    PERIODS_FILE = Wpcc::Engine.root.join('config', 'contribution_periods.yml')
    PERIODS = HashWithIndifferentAccess.new(YAML.load_file(PERIODS_FILE))

    def above_user_contributions
      periods.select do |_, percents|
        current_period?(percents) ||
          contribution_below_legal_minimum?(percents)
      end
    end

    private

    def periods
      PERIODS
    end

    def current_period?(percents)
      percents[:employee_percent].blank?
    end

    def contribution_below_legal_minimum?(percents)
      employee_percent < percents[:employee_percent] ||
        employer_percent < percents[:employer_percent]
    end
  end
end
