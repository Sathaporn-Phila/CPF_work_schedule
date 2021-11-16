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

ActiveRecord::Schema.define(version: 2021_11_14_152616) do

  create_table "histories", force: :cascade do |t|
    t.string "department_name"
    t.datetime "time_in"
    t.datetime "time_out"
    t.integer "user_id", null: false
    t.float "ot_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "schedule_actual_times", force: :cascade do |t|
    t.string "department_name"
    t.datetime "time_in"
    t.datetime "time_out"
    t.integer "user_id", null: false
    t.float "ot_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_schedule_actual_times_on_user_id"
  end

  create_table "schedule_plantimes", force: :cascade do |t|
    t.string "shift_code"
    t.datetime "time_in"
    t.datetime "time_out"
    t.float "ot_time"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_schedule_plantimes_on_user_id"
  end

  create_table "shiftcodes", force: :cascade do |t|
    t.string "code_name"
    t.datetime "start_in"
    t.datetime "end_in"
    t.datetime "start_break"
    t.datetime "end_break"
    t.float "work_time"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_shiftcodes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "employee_id"
    t.string "title_name"
    t.string "name"
    t.string "factory"
    t.string "department"
    t.datetime "hire_date"
    t.string "employee_income_type"
    t.string "password_digest"
    t.string "role"
    t.string "phone_number"
    t.integer "sector_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sector_id"], name: "index_users_on_sector_id"
  end

  add_foreign_key "histories", "users"
  add_foreign_key "schedule_actual_times", "users"
end
