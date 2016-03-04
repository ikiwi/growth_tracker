class User < ActiveRecord::Base
  validates :username, :email, :password_digest, presence: true
  validates_uniqueness_of :email
  has_secure_password
  has_many :goals
end