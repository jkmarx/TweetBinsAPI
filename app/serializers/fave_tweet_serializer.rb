class FaveTweetSerializer < ActiveModel::Serializer
  attributes :id, :userScreenname, :text, :userId, :user_id

end
