class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :twitterId
      t.belongs_to :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :friends, :categories
  end
end
