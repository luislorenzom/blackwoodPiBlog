class UsersController < ApplicationController

	before_action :anonymous_user?, only: [:new, :create]

	def index
		@users = User.paginate(:page => params[:page], :per_page => 5)
		authorize @users
	end

	def show
		@user = User.find(params[:id])
		authorize @user
	end

	def new
		@user = User.new
	end
   
	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to :controller => 'articles', :action => 'index'
		else
			render 'new'
		end
	end
		
	def profile
		@user = current_user
	end

	def destroy
		@user = User.find(params[:id])
        authorize @user
        @user.destroy

        redirect_to users_path
	end

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

		def anonymous_user?
			unless logged_in?
				redirect_to root_path
			end
		end
end
