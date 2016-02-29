class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users, except: [:created_at, :updated_at]
  end
  
  def new
  end

  def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Welcome #{@user.username}!"
        redirect_to root_path
      else
        flash[:notice] = "Error #{@user.errors.full_messages}"
        redirect_to new_user_path
      end
  end
  
  def show
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
