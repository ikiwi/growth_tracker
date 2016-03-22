class TagsController < ApplicationController
  def index
    @matches = Tag.where(hashtags: params[:tag])
    render json: @matches, except: [:created_at, :updated_at]
  end

  def create
    byebug
      @tag = Tag.new(hashtags: params[:hashtag])
      @tag.save
      render json: @tag, except: [:created_at, :updated_at]
  end

end
