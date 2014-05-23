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

	# GET /resource/password/edit?reset_password_token=abcdef
	def edit
		super
		token = Devise.token_generator.digest(User, :reset_password_token, params[:reset_password_token])
		user = User.where(reset_password_token: token).first
		if user
			resource.username = user.username
		else
			redirect_to new_user_password_path
		end
	end

	# PUT /resource/password
  def update
		token = Devise.token_generator.digest(User, :reset_password_token, resource_params[:reset_password_token])
		user = User.where(reset_password_token: token).first
		if user
			if resource_params[:password] != resource_params[:password_confirmation]
				self.resource = User.new do |u|
					u.reset_password_token = resource_params[:reset_password_token]
				end
				@error = "兩次密碼不相同，請重新輸入。"
				@mark_error = true
				render :edit
			elsif !(Devise.password_length.include? resource_params[:password].length)
				self.resource = User.new do |u|
					u.reset_password_token = resource_params[:reset_password_token]
				end
				@error = "密碼長度必須在 %d ~ %d 之間，請重新輸入。" % [Devise.password_length.min, Devise.password_length.max]
				@mark_error = true
				render :edit
			else
				self.resource = resource_class.reset_password_by_token(resource_params)
				yield resource if block_given?

				if resource.errors.empty?
					resource.unlock_access! if unlockable?(resource)
					sign_in(resource_name, resource)
					redirect_to after_resetting_password_path_for(resource)
				else
					respond_with resource
				end
			end
		else
			self.resource = User.new do |u|
				u.reset_password_token = resource_params[:reset_password_token]
			end
			@error = "重設密碼請求已過期或無效，請重新申請。"
			render :edit
		end
  end

end
