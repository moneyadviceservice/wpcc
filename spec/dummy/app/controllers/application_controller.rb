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
end
