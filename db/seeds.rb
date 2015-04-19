# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Category.delete_all

user1 = User.create!(twitterUsername: "jenniferkmarx", email: 'jennifer@fake.com', password: '')

cat1 = Category.create!(name: "Friends", user_id:user1.id)
cat2 = Category.create!(name: "Networking", user_id:user1.id)
cat3 = Category.create!(name: "Programming", user_id:user1.id)
