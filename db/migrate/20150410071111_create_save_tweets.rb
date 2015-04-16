class CreateSaveTweets < ActiveRecord::Migration
  def change
    create_table :save_tweets do |t|
      t.string :userScreenname
      t.string :text
      t.string :userId
      t.string :profile_image_url
      t.string :created_at
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :save_tweets, :users
  end
end
