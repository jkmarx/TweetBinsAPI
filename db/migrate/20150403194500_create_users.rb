class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitterUsername
      t.string :twitterUserId
      t.string :token
      t.string :accessToken, default: :null
      t.string :secretToken, default: :null
      t.timestamps null: false
    end
  end
end
