class Users::PasswordsController < Devise::PasswordsController
  # POST /resource/password
  def create
		user = User.where(username: resource_params[:username],
											email: resource_params[:email]
										 ).first
		if user
			self.resource = resource_class.send_reset_password_instructions(resource_params)
			yield resource if block_given?

			if successfully_sent?(resource)
				redirect_to new_user_session_path, flash: { info: "重設信件已經寄出，請更改密碼後重新登入。" }
			else
				self.resource = User.new do |u|
					u.username = resource_params[:username]
					u.email = resource_params[:email]
				end
				@error = "寄送失敗，請稍候再試。"
				render :new
			end
		else
			self.resource = User.new do |u|
				u.username = resource_params[:username]
				u.email = resource_params[:email]
			end
			@error = "帳號不存在或 E-mail 錯誤。"
			@mark_error = true
			render :new
		end
  end
end
