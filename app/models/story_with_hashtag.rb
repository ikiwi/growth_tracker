class StoryWithHashtag < ActiveRecord::Base
  belongs_to :stories
  belongs_to :tags
end
