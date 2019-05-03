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

ActiveRecord::Schema.define(version: 2019_05_02_164220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", force: :cascade do |t|
    t.bigint "heading_id"
    t.bigint "user_id"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rate", default: 0
    t.index ["heading_id"], name: "index_ads_on_heading_id"
    t.index ["user_id"], name: "index_ads_on_user_id"
  end

  create_table "auth_tokens", force: :cascade do |t|
    t.string "value"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "ad_id"
    t.text "text"
    t.integer "parent_id", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "rate", default: 0
    t.index ["ad_id"], name: "index_comments_on_ad_id"
    t.index ["parent_id"], name: "index_comments_on_parent_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "commune_users", force: :cascade do |t|
    t.bigint "commune_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commune_id"], name: "index_commune_users_on_commune_id"
    t.index ["user_id"], name: "index_commune_users_on_user_id"
  end

  create_table "communes", force: :cascade do |t|
    t.string "name"
    t.integer "polit_bank"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_communes_on_creator_id"
  end

  create_table "headings", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_headings_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.string "likeable_type"
    t.bigint "likeable_id"
    t.integer "kind", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likeable_type", "likeable_id"], name: "index_likes_on_likeable_type_and_likeable_id"
    t.index ["user_id", "likeable_id", "likeable_type"], name: "index_likes_on_user_id_and_likeable_id_and_likeable_type", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.bigint "subscriber_id"
    t.bigint "subscribing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriber_id", "subscribing_id"], name: "index_subscribers_on_subscriber_id_and_subscribing_id", unique: true
    t.index ["subscriber_id"], name: "index_subscribers_on_subscriber_id"
    t.index ["subscribing_id"], name: "index_subscribers_on_subscribing_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "login", null: false
    t.string "password_digest"
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
    t.integer "polit_power", default: 0
    t.index ["login"], name: "index_users_on_login"
  end

  add_foreign_key "ads", "headings"
  add_foreign_key "ads", "users"
  add_foreign_key "comments", "ads"
  add_foreign_key "comments", "users"
  add_foreign_key "commune_users", "communes"
  add_foreign_key "commune_users", "users"
  add_foreign_key "communes", "users", column: "creator_id"
  add_foreign_key "headings", "users"
  add_foreign_key "likes", "users"
  add_foreign_key "subscribers", "users", column: "subscriber_id"
  add_foreign_key "subscribers", "users", column: "subscribing_id"
end
