# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150410071111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["user_id"], name: "index_categories_on_user_id", using: :btree

  create_table "friends", force: :cascade do |t|
    t.string   "twitterId"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "friends", ["category_id"], name: "index_friends_on_category_id", using: :btree

  create_table "save_tweets", force: :cascade do |t|
    t.string   "userScreenname"
    t.string   "text"
    t.string   "userId"
    t.string   "profile_image_url"
    t.datetime "created_at",        null: false
    t.integer  "user_id"
    t.datetime "updated_at",        null: false
  end

  add_index "save_tweets", ["user_id"], name: "index_save_tweets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "token"
    t.string   "twitterUsername"
    t.string   "accessToken",     default: "null"
    t.string   "tokenSecret",     default: "null"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_foreign_key "categories", "users"
  add_foreign_key "friends", "categories"
  add_foreign_key "save_tweets", "users"
end
