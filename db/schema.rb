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

ActiveRecord::Schema.define(version: 20170526151300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agenda_items", force: :cascade do |t|
    t.bigint "unit_id"
    t.bigint "agenda_id"
    t.bigint "patient_id"
    t.datetime "scheduled_to"
    t.string "name"
    t.string "phone"
    t.integer "status"
    t.boolean "extra", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agenda_id"], name: "index_agenda_items_on_agenda_id"
    t.index ["patient_id"], name: "index_agenda_items_on_patient_id"
    t.index ["unit_id"], name: "index_agenda_items_on_unit_id"
  end

  create_table "agendas", force: :cascade do |t|
    t.bigint "unit_id"
    t.bigint "doctor_id"
    t.bigint "room_id"
    t.string "name"
    t.date "agenda_date"
    t.time "start_at"
    t.time "end_at"
    t.integer "interval"
    t.integer "count_event"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_agendas_on_doctor_id"
    t.index ["room_id"], name: "index_agendas_on_room_id"
    t.index ["unit_id"], name: "index_agendas_on_unit_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "treatment"
    t.string "name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_doctors_on_unit_id"
  end

  create_table "health_insurances", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_health_insurances_on_unit_id"
  end

  create_table "patients", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name", limit: 80
    t.bigint "health_insurance_id"
    t.date "birthday"
    t.string "gender", limit: 1
    t.string "phone"
    t.string "sms"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["health_insurance_id"], name: "index_patients_on_health_insurance_id"
    t.index ["unit_id"], name: "index_patients_on_unit_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.bigint "unit_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_rooms_on_unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.string "zipcode"
    t.string "state"
    t.string "city_name"
    t.string "address"
    t.string "address_complement"
    t.integer "address_number"
    t.string "neighborhood"
    t.string "email"
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
    t.bigint "unit_id"
    t.string "name"
    t.integer "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unit_id"], name: "index_users_on_unit_id"
  end

  add_foreign_key "agenda_items", "agendas"
  add_foreign_key "agenda_items", "patients"
  add_foreign_key "agenda_items", "units"
  add_foreign_key "agendas", "doctors"
  add_foreign_key "agendas", "rooms"
  add_foreign_key "agendas", "units"
  add_foreign_key "doctors", "units"
  add_foreign_key "health_insurances", "units"
  add_foreign_key "patients", "health_insurances"
  add_foreign_key "patients", "units"
  add_foreign_key "rooms", "units"
  add_foreign_key "users", "units"
end
