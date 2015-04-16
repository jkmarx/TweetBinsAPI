class UserSerializer < ActiveModel::Serializer
  attributes :id, :twitterUsername, :email, :token, :password_digest

  has_many :categories
  has_many :save_tweets
end
