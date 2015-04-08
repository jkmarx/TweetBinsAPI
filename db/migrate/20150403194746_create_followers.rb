class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.string :twitterId
      t.belongs_to :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :followers, :categories
  end
end
