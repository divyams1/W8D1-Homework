class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :logged_in?, :current_user, :logout
    def log_in!(user)
         session[:session_token] = user.reset_session_token!
         
    end

    def ensure_logged_in? 
        redirect_to new_session_url unless logged_in? 
    end

    def logged_in?
        !!current_user
    end
    
    def current_user 
        @current_user = User.find_by(session_token: session[:session_token])
    end

    def logout
        current_user.reset_session_token! 
        session[:session_token] = nil 
        @current_user = nil
    end

    def require_moderator
        redirect_to subs_url unless current_user.subs.ids.include?(params[:id].to_i)
    end
end
