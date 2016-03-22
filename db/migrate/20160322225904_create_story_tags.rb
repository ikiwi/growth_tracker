class CreateStoryTags < ActiveRecord::Migration
  def change
    create_table :story_tags do |t|

      t.integer :story_id
      t.integer :tag_id
      t.timestamps null: false
    end
  end
end
