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

ActiveRecord::Schema[8.1].define(version: 2026_06_18_150407) do
  create_table "groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "order", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_nations", id: false, force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "nation_id", null: false
    t.index ["group_id", "nation_id"], name: "index_groups_nations_on_group_id_and_nation_id", unique: true
    t.index ["nation_id"], name: "index_groups_nations_on_nation_id"
  end

  create_table "nations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "fifa_place", null: false
    t.integer "fifa_rank", null: false
    t.string "flag_emoji", null: false
    t.string "name", null: false
    t.string "normalized_name"
    t.integer "price", default: 0, null: false
    t.datetime "updated_at", null: false
  end

  create_table "nations_squads", id: false, force: :cascade do |t|
    t.bigint "nation_id", null: false
    t.bigint "squad_id", null: false
    t.index ["nation_id", "squad_id"], name: "index_nations_squads_on_nation_id_and_squad_id", unique: true
    t.index ["squad_id"], name: "index_nations_squads_on_squad_id"
  end

  create_table "squads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description"
    t.boolean "main", default: false, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_squads_on_user_id"
    t.index ["user_id"], name: "index_squads_on_user_id_main_unique", unique: true, where: "main = true"
  end

  create_table "users", force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "role", default: 0, null: false
    t.string "secret", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["secret"], name: "index_users_on_secret", unique: true
  end

  add_foreign_key "groups_nations", "groups"
  add_foreign_key "groups_nations", "nations"
  add_foreign_key "nations_squads", "nations"
  add_foreign_key "nations_squads", "squads"
  add_foreign_key "squads", "users"
end
