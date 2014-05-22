class Users::RegistrationsController < Devise::RegistrationsController
	def create
		# Disable create method
		redirect_to new_user_registration_path, alert: "註冊功能已關閉"
	end
end
