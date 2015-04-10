class CreateFaveTweets < ActiveRecord::Migration
  def change
    create_table :fave_tweets do |t|
      t.string :userScreenname
      t.string :text
      t.string :userId
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :fave_tweets, :users
  end
end
