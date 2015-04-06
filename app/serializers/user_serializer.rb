class UserSerializer < ActiveModel::Serializer
  attributes :id, :twitterUsername, :twitterUserId, :token

end
