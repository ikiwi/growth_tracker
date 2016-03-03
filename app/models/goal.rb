class Goal < ActiveRecord::Base
  validates :title, :desc, presence: true
  belongs_to :users
end
