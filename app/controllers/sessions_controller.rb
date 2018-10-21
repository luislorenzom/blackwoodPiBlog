class SessionsController < ApplicationController
  
  before_action :anonymous_user?, except: [:destroy]

  # ------------------------------------------------------------
  # Prepares the new session to will be created
  # ------------------------------------------------------------
  def new
  end

  # ------------------------------------------------------------
  # Creates the new session
  # ------------------------------------------------------------
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user
      log_in user
      redirect_to :controller => 'articles', :action => 'index'
    else
      # Error message
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  # ------------------------------------------------------------
  # Destroys a session
  # ------------------------------------------------------------
  def destroy
    log_out
    redirect_to root_url
  end

  private
    # ------------------------------------------------------------
    # Checks if the user is logged in
    # ------------------------------------------------------------
    def anonymous_user?
      unless logged_in?
        redirect_to root_path
      end
    end
end
