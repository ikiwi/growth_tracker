class GoalsController < ApplicationController
  def index
    @goals = Goal.all
    render json: @goals, except: [:created_at, :updated_at]
  end
  
  def create
      @goal = Goal.new(goal_params)
      if @goal.save
        flash[:notice] = "#{@goal.title} saved!"
      else
        flash[:notice] = "Error saving #{@goal.title}"
      end
      redirect_to root_path
  end

  def save
  end
  
  private
    def goal_params
      params.require(:goal).permit(:title, :desc)
    end
end
