class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
	# authorize_resource :unless => :devise_controller?
	check_authorization :unless => :devise_controller?

	rescue_from CanCan::AccessDenied do |exception|
		if current_user.blank?
			redirect_to new_user_session_url, :alert => exception.message
		else
			redirect_to root_url, :alert => exception.message
		end
	end
end
