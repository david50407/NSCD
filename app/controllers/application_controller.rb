class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	# authorize_resource :unless => :devise_controller?
	check_authorization :unless => :devise_controller?
	before_filter :configure_permitted_parameters, if: :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
		Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
		if current_user.blank?
			redirect_to new_user_session_url, :alert => exception.message
		else
			redirect_to root_url, :alert => exception.message
		end
	end

	protected
	def configure_permitted_parameters
		devise_parameter_sanitizer.for :sign_up do |u|
			u.permit(:username, 
							 :email, 
							 :password, :password_confirmation, 
							 :remember_me)
		end
		devise_parameter_sanitizer.for :sign_in do |u|
			u.permit(:username,
							 :password,
							 :remember_me)
		end
		devise_parameter_sanitizer.for :account_update do |u|
			u.permit(:username, 
							 :email, 
							 :password, :password_confirmation, 
							 :current_password)
		end
	end
end
