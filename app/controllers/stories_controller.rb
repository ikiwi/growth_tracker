class StoriesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :json

  def index
    if (current_user)
      @stories = Story.active.where(user_id: current_user.id)
    else
      @stories = Story.active.published
    end
  end

  def featured
    @stories = Story.published.featured.active
    render :index
  end

  def destroy
    @story = Story.find_by_id(params[:id])
    @story.archived = true
    @story.save
    render json: @story, except: [:created_at, :updated_at]
  end

  def show
    @story = Story.find_by_id(params[:id])
  end

  def create
      @story = Story.new(story_params)
      @story.user_id = current_user.id
      @story.archived = false
      @story.featured = false
      @story.published = false
      @story.save
      render json: @story, except: [:created_at, :updated_at]
  end

  def update
    @story = Story.find_by_id(params[:$story][:id])
    @story.title = params[:$story][:title]
    @story.text = params[:$story][:text]
    @story.featured = params[:$story][:featured]
    @story.published = params[:$story][:published]
    @hashtags = []
    params[:hashtags].each do |t|
      tag = Tag.find_by(hashtags: t)
      if tag == nil
        tag = Tag.create(hashtags: t)
      end
      @hashtags << tag.id
    end
    @story.tag_ids = @hashtags
    @story.save
    render :show
  end

  private
    def story_params
      params.require(:story).permit(:title, :text)
    end

end
