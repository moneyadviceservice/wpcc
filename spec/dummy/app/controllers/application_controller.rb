class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale]
  end
end
