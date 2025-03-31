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

ActiveRecord::Schema[7.1].define(version: 2024_12_11_184852) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "measures", force: :cascade do |t|
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nonconformities", force: :cascade do |t|
    t.string "latitude"
    t.string "longitude"
    t.string "measure"
    t.string "quadrant"
    t.string "nonconformityLevel"
    t.string "nonconformityLocal"
    t.string "nonconformityType"
    t.string "vehiclePart"
    t.string "username"
    t.bigint "vehicle_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_id"], name: "index_nonconformities_on_vehicle_id"
  end

  create_table "nonconformity_levels", force: :cascade do |t|
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nonconformity_locals", force: :cascade do |t|
    t.string "local"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nonconformity_types", force: :cascade do |t|
    t.string "ncType"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quadrants", force: :cascade do |t|
    t.string "option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "synced_vehicles", id: :bigint, default: -> { "nextval('vehicles_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "chassis"
    t.string "model"
    t.string "brand"
    t.string "ship"
    t.string "situation"
    t.string "status"
    t.string "location"
    t.string "observations"
    t.string "travel"
    t.string "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mongo_id"
    t.string "et_chassis_image_filename"
    t.string "et_chassis_image_gridfs_id"
    t.string "profile_image_filename"
    t.string "profile_image_gridfs_id"
    t.string "front_image_filename"
    t.string "front_image_gridfs_id"
    t.string "back_image_filename"
    t.string "back_image_gridfs_id"
    t.index ["chassis"], name: "unique_chassis", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "role", default: "", null: false
    t.string "name", default: "", null: false
    t.string "login", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
