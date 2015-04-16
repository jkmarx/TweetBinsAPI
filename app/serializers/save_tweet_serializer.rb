class SaveTweetSerializer < ActiveModel::Serializer
  attributes :id, :userScreenname, :text, :userId, :user_id, :created_at, :profile_image_url

end
