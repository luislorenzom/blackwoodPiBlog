class UsersController < ApplicationController

	before_action :anonymous_user?, only: [:new, :create]

	# ------------------------------------------------------------
	# Shows all the users
	# ------------------------------------------------------------
	def index
		@users = User.paginate(:page => params[:page], :per_page => 5)
		authorize @users
	end

	# ------------------------------------------------------------
	# Shows the user information
	# ------------------------------------------------------------
	def show
		@user = User.find(params[:id])
		authorize @user
	end

	# ------------------------------------------------------------
	# Prepares a new to will be created
	# ------------------------------------------------------------
	def new
		@user = User.new
	end

   	# ------------------------------------------------------------
	# Saves a new user with the enabled status to false
	# ------------------------------------------------------------
	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to :controller => 'welcome', :action => 'index'
			flash[:info] = 'Wait until admin enables your account'
		else
			render 'new'
		end
	end

	# ------------------------------------------------------------
	# Shows the current user information
	# ------------------------------------------------------------
	def profile
		@user = current_user
	end

	# ------------------------------------------------------------
	# Changes the users enabled status to "False"
	# ------------------------------------------------------------
	def destroy
		@user = User.find(params[:id])
        authorize @user
        @user.destroy

        redirect_to users_path
	end

	# ------------------------------------------------------------
	# Changes the users enabled status to "True"
	# ------------------------------------------------------------
	def revive
		@user = User.find(params[:user_id])
        authorize @user
        @user.revive

        redirect_to users_path
	end	

	private

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end

		# ------------------------------------------------------------
		# Check if there is an user logged in
		# ------------------------------------------------------------
		def anonymous_user?
			unless logged_in?
				redirect_to root_path
			end
		end
end
