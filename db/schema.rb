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

ActiveRecord::Schema.define(version: 2018_10_16_202440) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cars", force: :cascade do |t|
    t.string "plate"
    t.string "brand"
    t.string "model"
    t.decimal "current_km"
    t.string "car_type"
    t.decimal "week_km"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.datetime "km_updated_date"
    t.index ["owner_id"], name: "index_cars_on_owner_id"
  end

  create_table "cost_details", force: :cascade do |t|
    t.string "cost_type"
    t.decimal "cost"
    t.text "provider"
    t.bigint "maintenance_history_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["maintenance_history_id"], name: "index_cost_details_on_maintenance_history_id"
  end

  create_table "maintenance_histories", force: :cascade do |t|
    t.string "status"
    t.decimal "estimated_km"
    t.datetime "scheduled_date"
    t.decimal "review_km"
    t.datetime "review_date"
    t.text "provider"
    t.decimal "cost"
    t.boolean "notified"
    t.bigint "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "maintenance_type"
    t.bigint "user_car_setting_id"
    t.decimal "gallons"
    t.index ["car_id"], name: "index_maintenance_histories_on_car_id"
    t.index ["user_car_setting_id"], name: "index_maintenance_histories_on_user_car_setting_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "cel_phone"
    t.boolean "agreement_terms", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.integer "user_id"
    t.index ["email"], name: "index_owners_on_email", unique: true
  end

  create_table "settings", force: :cascade do |t|
    t.integer "car_age"
    t.integer "km_max"
    t.integer "km_min"
    t.integer "month_max"
    t.integer "month_min"
    t.string "car_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "maintenance_type"
  end

  create_table "user_car_settings", force: :cascade do |t|
    t.integer "car_id"
    t.integer "km_estimated"
    t.integer "month_estimated"
    t.string "maintenance_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cars", "owners"
  add_foreign_key "cost_details", "maintenance_histories"
  add_foreign_key "maintenance_histories", "cars"
  add_foreign_key "maintenance_histories", "user_car_settings"
end
