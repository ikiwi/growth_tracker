class RemoveHashtagFromStory < ActiveRecord::Migration
  def change
    remove_column :stories, :hashtag, :string
  end
end
