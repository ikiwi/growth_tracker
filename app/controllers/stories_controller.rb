class StoriesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :json

  def index
    if (current_user)
      @stories = Story.active.where(user_id: current_user.id)
      render json: @stories, except: [:created_at, :updated_at]
    end
  end

  def featured
    @stories = Story.featured.active
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
      @story.featured = true
      @story.save
      render json: @story, except: [:created_at, :updated_at]
  end

  def update
      @story = Story.find_by_id(params[:id])
      @story.hashtag = params[:hashtag]
      @story.title = params[:title]
      @story.text = params[:text]
      @story.save
      render json: @story, except: [:created_at, :updated_at]
  end

  private
    def story_params
      params.require(:story).permit(:title, :text, :archived)
    end

end
