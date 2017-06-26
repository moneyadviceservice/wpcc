class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  before_action :set_locale

  def parent_template
    'layouts/application'
  end
  helper_method :parent_template

  private

  def set_locale
    I18n.locale = params[:locale]
  end

  def alternate_locales
    I18n.available_locales - Array(I18n.locale)
  end
  helper_method :alternate_locales

  def default_url_options(_options = {})
    { locale: I18n.locale }
  end
end
