class Category < ActiveRecord::Base
  belongs_to :user
  has_many :followers, dependent: :destroy
end
