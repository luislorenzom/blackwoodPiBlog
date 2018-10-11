class SessionsController < ApplicationController
  
  before_action :anonymous_user?, except: [:destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    authorize user
    if user && user.authenticate(params[:session][:password])
      # Log the user
      log_in user
      redirect_to :controller => 'articles', :action => 'index'
    else
      # Error message
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

    def anonymous_user?
      unless logged_in?
        redirect_to root_path
      end
    end
end
