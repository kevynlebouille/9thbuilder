class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout -> (controller) { controller.request.xhr? ? false : 'application' }

  def set_locale
    I18n.locale = params[:locale] || http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_up) << :favorite_army_id
    devise_parameter_sanitizer.for(:sign_up) << :locale
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :favorite_army_id
    devise_parameter_sanitizer.for(:account_update) << :locale
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a? AdminUser
      admin_dashboard_path
    else
      army_lists_path
    end
  end
end
