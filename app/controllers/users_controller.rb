class UsersController < ApplicationController
	before_action :logged_in_user
	before_action :correct_user

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in(@user)
			flash[:success] = "User successfully created"
			redirect_to @user
		else
			flash.now[:danger] = "Error"
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])

	end

	private

		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to root_url unless current_user?(@user)
		end

end
