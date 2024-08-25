class SessionsController < ApplicationController
  def new
    # This will render the login form
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      login user
      redirect_to root_path, notice: "You have signed in successfully."
    else
      flash[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "You have been logged out"
  end

  private

  def login(user)
    session[:user_id] = user.id
    Current.user = user
  end

  def logout
    Current.user = nil
    reset_session
  end
end
