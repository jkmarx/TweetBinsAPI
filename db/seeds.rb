# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all
Category.delete_all
Follower.delete_all

user1 = User.create!(twitterUsername: "jenniferkmarx", email: 'jennifer@fake.com', password: '')

cat1 = Category.create!(name: "Friends", user_id:user1.id)
cat2 = Category.create!(name: "Networking", user_id:user1.id)

# fol1 = Follower.create!(twitter_handle: "annie_runs", category_id: cat1.id)
# fol2 = Follower.create!(twitter_handle: "cgpacifico", category_id: cat1.id)
# fol3 = Follower.create!(twitter_handle: "@judngu", category_id: cat2.id)
# fol4 = Follower.create!(twitter_handle: "jboursiquot", category_id: cat2.id)
