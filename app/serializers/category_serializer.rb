class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :friends
end
