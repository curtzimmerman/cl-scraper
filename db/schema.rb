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

ActiveRecord::Schema.define(version: 20150616134423) do

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hits", force: :cascade do |t|
    t.integer  "search_id"
    t.string   "url"
    t.string   "title"
    t.integer  "price"
    t.string   "neighborhood"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "nearby_cities", id: false, force: :cascade do |t|
    t.integer "home_city_id"
    t.integer "city_id"
  end

  add_index "nearby_cities", ["city_id"], name: "index_nearby_cities_on_city_id"
  add_index "nearby_cities", ["home_city_id"], name: "index_nearby_cities_on_home_city_id"

  create_table "searches", force: :cascade do |t|
    t.string   "title"
    t.string   "query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "location"
  end

  add_index "searches", ["user_id"], name: "user_id_ix"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
