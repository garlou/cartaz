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

ActiveRecord::Schema.define(version: 2019_02_07_172626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genres", force: :cascade do |t|
    t.string "genre"
    t.string "platform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "year"
    t.string "runtime"
    t.jsonb "genres", default: []
    t.jsonb "platforms", default: []
    t.datetime "last_scrap"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.datetime "last_avaliation", default: "2019-02-07 17:29:50"
  end

  create_table "scores", force: :cascade do |t|
    t.string "scorable_type"
    t.bigint "scorable_id"
    t.string "title"
    t.string "year"
    t.string "api"
    t.string "source"
    t.string "rating"
    t.string "votes"
    t.string "released"
    t.string "director"
    t.string "writer"
    t.string "language"
    t.string "country"
    t.string "poster"
    t.string "sourceid"
    t.float "similarity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["scorable_type", "scorable_id"], name: "index_scores_on_scorable_type_and_scorable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
