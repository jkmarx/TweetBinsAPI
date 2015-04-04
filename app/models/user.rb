class User < ActiveRecord::Base
  has_many :categories
  has_one :user_authentication, dependent: :destroy
end
