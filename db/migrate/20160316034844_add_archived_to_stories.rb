class AddArchivedToStories < ActiveRecord::Migration
  def change
    add_column :stories, :archived, :boolean
  end
end
