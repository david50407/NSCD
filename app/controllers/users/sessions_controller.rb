class Users::SessionsController < Devise::SessionsController
	def create
		self.resource = warden.authenticate(auth_options)
		if self.resource
			set_flash_message(:notice, :signed_in) if is_flashing_format?
			sign_in(resource_name, resource)
			yield resource if block_given?
			respond_with resource, location: after_sign_in_path_for(resource)
		else
			self.resource = User.new do |u|
				u.username = resource_params[:username]
			end
			@error = "帳號不存在或密碼錯誤。"
			render :new
		end
	end
end
