class Story < ActiveRecord::Base
  has_many :story_tags, class_name: "StoryTag"
  has_many :tags, :through => :story_tags
  validates :title, :text, :user_id, presence: true
  belongs_to :users
  scope :featured, -> { where(featured: true) }
  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  scope :published, -> { where(published: true) }
  accepts_nested_attributes_for :tags
end