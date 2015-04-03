class CreateUserAuthentications < ActiveRecord::Migration
  def change
    create_table :user_authentications do |t|
      t.belongs_to :user, index: true
      t.string :token
      t.datetime :token_expires_at

      t.timestamps null: false
    end
    add_foreign_key :user_authentications, :users
  end
end
