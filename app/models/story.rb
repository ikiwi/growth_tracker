class Story < ActiveRecord::Base
  has_and_belongs_to_many :tags
  belongs_to :accounts
  scope :featured, -> { where(featured: true) }
end
