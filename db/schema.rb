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

ActiveRecord::Schema[8.0].define(version: 2025_04_19_002847) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "skins", force: :cascade do |t|
    t.string "name", null: false
    t.string "weapon", null: false
    t.string "category"
    t.string "wear_level"
    t.decimal "float_value", precision: 18, scale: 17
    t.integer "pattern_template"
    t.string "image_url"
    t.string "inspect_link"
    t.decimal "price", precision: 10, scale: 2
    t.boolean "for_sale", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_skins_on_category"
    t.index ["for_sale"], name: "index_skins_on_for_sale"
    t.index ["price"], name: "index_skins_on_price"
    t.index ["user_id"], name: "index_skins_on_user_id"
    t.index ["weapon"], name: "index_skins_on_weapon"
    t.index ["wear_level"], name: "index_skins_on_wear_level"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "nickname"
    t.string "avatar_url"
    t.string "profile_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "skins", "users"
end
