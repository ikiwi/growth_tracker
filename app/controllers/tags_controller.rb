class TagsController < ApplicationController
  def index
    @tags = Tag.all
    render json: @tags, except: [:created_at, :updated_at]
  end

  def show
    @matches = Tag.where(hashtags: params[:id])
    render json: @matches, except: [:created_at, :updated_at]
  end

  def create
      @tag = Tag.new(hashtags: params[:hashtag])
      @tag.save
      render json: @tag, except: [:created_at, :updated_at]
  end

end
