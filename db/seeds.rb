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
cat3 = Category.create!(name: "Programming", user_id:user1.id)

fol1 = Follower.create!(twitterId: "127333124", category_id: cat1.id)
fol2 = Follower.create!(twitterId: "28858879", category_id: cat1.id)
fol3 = Follower.create!(twitterId: "1891841460", category_id: cat2.id)
fol4 = Follower.create!(twitterId: "1577210616", category_id: cat2.id)
fol5 = Follower.create!(twitterId: "3066074152", category_id: cat3.id)
fol6 = Follower.create!(twitterId: "100667258", category_id: cat3.id)
fol7 = Follower.create!(twitterId: "20704166", category_id: cat3.id)
fol8 = Follower.create!(twitterId: "3035323810", category_id: cat2.id)
fol9 = Follower.create!(twitterId: "127333124", category_id: cat1.id)
fol10 = Follower.create!(twitterId: "90090339", category_id: cat1.id)
fol11 = Follower.create!(twitterId: "2949464685", category_id: cat2.id)
fol12 = Follower.create!(twitterId: "2345988834", category_id: cat3.id)
