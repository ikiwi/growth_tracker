class RemoveStoryidFromTag < ActiveRecord::Migration
  def change
    remove_column :tags, :story_id, :string
  end
end
