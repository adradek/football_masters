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

ActiveRecord::Schema[8.1].define(version: 2026_06_07_133940) do
  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "order", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_nations", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "nation_id", null: false
  end

  create_table "nations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "fifa_place", null: false
    t.integer "fifa_rank", null: false
    t.string "flag_emoji", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end
end
