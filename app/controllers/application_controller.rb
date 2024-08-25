class ApplicationController < ActionController::Base
  # Assuming you have a custom method or gem for browser checks

  # allow_browser versions: :modern

  private

  def current_user
    Current.user ||= authenticate_user_from_session
  end
  helper_method :current_user

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout
    Current.user = nil
    reset_session
  end

  def require_login
    unless user_signed_in?
      flash[:alert] = "You need to log in to access this page."
      redirect_to new_session_path
    end
  end
end
