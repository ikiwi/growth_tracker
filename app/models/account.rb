class Account < ActiveRecord::Base
  has_many :stories
end
