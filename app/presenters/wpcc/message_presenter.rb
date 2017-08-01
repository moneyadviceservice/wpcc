module Wpcc
  class MessagePresenter < Presenter
    def manually_opt_in_message?
      text == :manually_opt_in && manually_opt_in?
    end

    def manually_opt_in_message
      t('wpcc.contributions.manually_opt_in')
    end
  end
end
