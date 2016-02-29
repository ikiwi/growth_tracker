class User < ActiveRecord::Base
  validates :username, :email, :password_digest, presence: true
  has_secure_password
end