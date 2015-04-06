class UserSerializer < ActiveModel::Serializer
  attributes :id, :twitterUsername, :twitterUserId, :appToken

end
