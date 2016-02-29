class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users, except: [:created_at, :updated_at]
  end
  
  def new
  end

  def create
    if User.where(email: params[:email]).empty
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "welcome #{count}"
        redirect_to '/'
      end
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