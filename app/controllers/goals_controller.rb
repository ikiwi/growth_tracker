class GoalsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    @goals = Goal.where(user_id: current_user.id)
    render json: @goals, except: [:created_at, :updated_at]
  end

  def show
    @goal = Goal.find_by_id(params[:id])
    render json: @goal, except: [:created_at, :updated_at]
  end

  def create
      @goal = Goal.new(goal_params)
      @goal.user_id = current_user.id
      @goal.save
      render json: @goal, except: [:created_at, :updated_at]
  end

  def save
  end

  def destroy
      Goal.find_by_id(params[:id]).destroy
      render json: @goal, except: [:created_at, :updated_at]
  end

  private
    def goal_params
      params.require(:goal).permit(:title, :desc)
    end
end
