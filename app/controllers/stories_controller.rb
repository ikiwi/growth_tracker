class StoriesController < ApplicationController
  respond_to :json

  def index
    @stories = Story.all
    render json: @stories, except: [:created_at, :updated_at]
  end

  def show
    @story = Story.find_by_id(params[:id])
    render json: @story, except: [:created_at, :updated_at]
  end

end
