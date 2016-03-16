class StoriesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :json

  def index
    @stories = Story.where(user_id: current_user.id, archived: false)
    render json: @stories, except: [:created_at, :updated_at]
  end
  
  def featured
    @stories = Story.where(archived: false)
    render json: @stories, except: [:created_at, :updated_at]
  end
  
  def destroy
    @story = Story.find_by_id(params[:id])
    @story.archived = true
    @story.save
    render json: @story, except: [:created_at, :updated_at]
  end

  def show
    @story = Story.find_by_id(params[:id])
    render json: @story, except: [:created_at, :updated_at]
  end
  
  def create
      @story = Story.new(story_params)
      @story.user_id = current_user.id
      @story.save
      render json: @story, except: [:created_at, :updated_at]
  end

  def save
      @story = Story.find_by_id(params[:id])
      @story.hashtag = params[:hashtag]
      @story.title = params[:title]
      @story.text = params[:text]
      @story.save
  end

  private
    def story_params
      params.require(:story).permit(:title, :text, :archived)
    end

end
