# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
  end

  private

  def set_current_user
    Current.user = current_user
  end
end
