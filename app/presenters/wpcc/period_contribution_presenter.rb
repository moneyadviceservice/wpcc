module Wpcc
  class PeriodContributionPresenter < SimpleDelegator
    def initialize(args = {})
      super(args[:period_contribution])
      @translator = args[:translator]
    end

    def title
      text_for("wppc.results.period_title.#{name}")
    end
    
    private

    attr_reader :translator
    
    def text_for(period_title)
      translator.call("wpcc.results.period_title.#{period_title}")
    end
  end
end
