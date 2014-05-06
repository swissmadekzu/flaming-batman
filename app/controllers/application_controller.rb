class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :set_layout

  private
  def set_locale
    I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
  end
  
  def set_layout
    if current_user.nil?
      self.class.layout "loginscreen"
    end
  end
end
