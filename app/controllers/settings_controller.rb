class SettingsController < ApplicationController
	authorize_resource User
	skip_authorization_check :only => :index
	before_filter :load_user, :except => :index

	def index
		redirect_to :action => :profile
	end
	
	def profile
	end

	def profile_update
		@user.firstname = profile_params[:firstname]
		@user.lastname = profile_params[:lastname]
		@user.nickname = profile_params[:nickname]
		@user.phone = profile_params[:phone]
		@user.save
		flash[:success] = "更新成功"
		redirect_to :action => :profile
	end

	def account
	end

	private

	def load_user
		@user = User.find current_user
	end

	def profile_params
		params.require(:user).permit(:lastname, :firstname, :nickname, :phone)
	end
end
