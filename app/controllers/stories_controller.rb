class StoriesController < ApplicationController
  respond_to :json

  def index
    @stories = Story.all
    respond_with (@stories)
  end
end
