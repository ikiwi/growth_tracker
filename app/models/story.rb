class Story < ActiveRecord::Base
  has_and_belongs_to_many :tags
  validates :title, :text, :user_id, presence: true
  belongs_to :users
  scope :featured, -> { where(featured: true) }
end
