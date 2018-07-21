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

ActiveRecord::Schema.define(version: 2018_07_21_204121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["car_id"], name: "index_maintenance_histories_on_car_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "cel_phone"
    t.boolean "agreement_terms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
  end

  add_foreign_key "cars", "owners"
  add_foreign_key "cost_details", "maintenance_histories"
  add_foreign_key "maintenance_histories", "cars"
end
