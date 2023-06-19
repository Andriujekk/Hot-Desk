# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_19_230204) do
  create_table "desks", force: :cascade do |t|
    t.integer "floor_number"
    t.integer "pos_x"
    t.integer "pos_y"
    t.string "booked_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_desks_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "floor_number"
    t.string "booked_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "top_left_x"
    t.integer "top_left_y"
    t.integer "width"
    t.integer "height"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id"
    t.string "name"
    t.string "login"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "isAdmin"
  end

  add_foreign_key "desks", "users"
  add_foreign_key "rooms", "users"
end
