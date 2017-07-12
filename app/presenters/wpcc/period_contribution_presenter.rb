module Wpcc
  class PeriodContributionPresenter < SimpleDelegator
    delegate :t, to: :view_context

    attr_reader :object, :view_context

    def initialize(object, args = {})
      super(object)
      @view_context = args[:view_context]
    end

    def title
      t("wpcc.results.period_title.#{name}")
    end
  end
end
