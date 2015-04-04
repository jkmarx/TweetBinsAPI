class UserSerializer < ActiveModel::Serializer
  attributes :id, :twitterUsername

  has_many :categories
end
