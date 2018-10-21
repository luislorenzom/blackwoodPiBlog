class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
    include SessionsHelper
    include Pundit

    private
        # ------------------------------------------------------------
        # Actions to not authorized users
        # ------------------------------------------------------------
        def user_not_authorized
            #flash[:alert] = "You are not cool enough to do this - go back from whence you came."
            redirect_to root_path
        end
end
