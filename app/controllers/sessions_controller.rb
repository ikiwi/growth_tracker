class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
    else
      flash[:notice] = "Cannot login"
    end
    redirect_to root_path
  end

  def destroy
      session[:user_id] = nil
      redirect_to root_path
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
