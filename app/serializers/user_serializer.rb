class UserSerializer < ActiveModel::Serializer
  attributes :id, :twitterUsername, :email, :token, :password_digest
end
