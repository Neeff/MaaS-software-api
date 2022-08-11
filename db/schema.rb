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

ActiveRecord::Schema.define(version: 2022_08_11_015307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "available_hours", force: :cascade do |t|
    t.string "description"
    t.string "start_hour"
    t.string "end_hour"
    t.date "date"
    t.bigint "service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "week"
    t.index ["service_id"], name: "index_available_hours_on_service_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.json "business_days"
    t.integer "init_hour"
    t.integer "finish_hour"
    t.integer "init_weekend_hour"
    t.integer "finish_weekend_hour"
    t.bigint "service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_contracts_on_service_id"
  end

  create_table "engineer_available_hours", force: :cascade do |t|
    t.bigint "engineer_id", null: false
    t.bigint "available_hour_id", null: false
    t.boolean "active", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["available_hour_id"], name: "index_engineer_available_hours_on_available_hour_id"
    t.index ["engineer_id"], name: "index_engineer_available_hours_on_engineer_id"
  end

  create_table "engineers", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.bigint "service_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["service_id"], name: "index_engineers_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "company_name"
    t.integer "weekly_hours"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.bigint "engineer_id", null: false
    t.string "start_hour"
    t.string "end_hour"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["engineer_id"], name: "index_shifts_on_engineer_id"
  end

  add_foreign_key "available_hours", "services"
  add_foreign_key "contracts", "services"
  add_foreign_key "engineer_available_hours", "available_hours"
  add_foreign_key "engineer_available_hours", "engineers"
  add_foreign_key "engineers", "services"
  add_foreign_key "shifts", "engineers"
end
