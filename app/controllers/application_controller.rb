class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def upload_params
  	params.require(:raw_file).permit(:comment, :upload, :content_id)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:userid, :password, :remember_me) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :userid, :password, :password_confirmation) }
  end

  def set_current_user
      User.current = current_user
      true
  end
end
