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

ActiveRecord::Schema[7.1].define(version: 2024_07_30_111325) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.decimal "amount", precision: 6, scale: 2
    t.date "date"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "schedule_id", null: false
    t.bigint "pnr_number"
    t.uuid "payment_id"
    t.index ["payment_id"], name: "index_bookings_on_payment_id"
    t.index ["schedule_id"], name: "index_bookings_on_schedule_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "chats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "participants", default: [], array: true
  end

  create_table "coaches", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tier_id"
    t.text "description"
    t.index ["tier_id"], name: "index_coaches_on_tier_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "sender_id", null: false
    t.uuid "chat_id", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "payments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "paid_amount", precision: 6, scale: 2
    t.decimal "refund_amount", precision: 6, scale: 2
    t.decimal "cancelation_charges", precision: 6, scale: 2
    t.bigint "transaction_id", null: false
    t.string "mode"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["transaction_id"], name: "index_payments_on_transaction_id", unique: true
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "train_id", null: false
    t.string "arrived_at"
    t.string "departure_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "source_station_id"
    t.bigint "destination_station_id"
    t.decimal "distance", precision: 6, scale: 2
    t.index ["destination_station_id"], name: "index_schedules_on_destination_station_id"
    t.index ["source_station_id"], name: "index_schedules_on_source_station_id"
    t.index ["train_id"], name: "index_schedules_on_train_id"
  end

  create_table "seats", force: :cascade do |t|
    t.integer "number"
    t.string "berth"
    t.string "position"
    t.bigint "coach_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coach_id"], name: "index_seats_on_coach_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "abbr"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "gender"
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "seat_id"
    t.string "status"
    t.index ["booking_id"], name: "index_tickets_on_booking_id"
    t.index ["seat_id"], name: "index_tickets_on_seat_id"
  end

  create_table "tiers", force: :cascade do |t|
    t.string "name"
    t.string "short_form"
    t.decimal "price_per_km", precision: 6, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trains", force: :cascade do |t|
    t.string "name"
    t.integer "uniq_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "working_days", array: true
    t.integer "coaches", default: [], array: true
    t.string "category"
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "role_id", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "gender"
    t.string "user_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_token"
    t.string "account_status"
  end

  add_foreign_key "bookings", "payments"
  add_foreign_key "bookings", "schedules"
  add_foreign_key "bookings", "schedules"
  add_foreign_key "bookings", "users"
  add_foreign_key "coaches", "tiers"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "payments", "users"
  add_foreign_key "schedules", "stations", column: "destination_station_id"
  add_foreign_key "schedules", "stations", column: "source_station_id"
  add_foreign_key "schedules", "trains"
  add_foreign_key "seats", "coaches"
  add_foreign_key "tickets", "bookings"
  add_foreign_key "tickets", "seats"
end
