class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :hashtags
      t.integer :story_id

      t.timestamps null: false
    end
  end
end
