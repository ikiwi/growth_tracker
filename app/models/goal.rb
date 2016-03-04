class Goal < ActiveRecord::Base
  validates :title, :desc, :user_id, presence: true
  belongs_to :users
end
