class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :token
      t.string :twitterUsername
      t.string :accessToken, default: :null
      t.string :tokenSecret, default: :null
      t.timestamps null: false
    end
  end
end
