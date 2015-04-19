class Category < ActiveRecord::Base
  belongs_to :user
  has_many :friends, dependent: :destroy

  validates_uniqueness_of :friends, scope: :twitterId
end
