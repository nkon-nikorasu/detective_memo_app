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

ActiveRecord::Schema[7.2].define(version: 2026_09_29_041951) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "google_books_id", null: false
    t.string "title", null: false
    t.string "authors", default: [], null: false, array: true
    t.string "thumbnail_url"
    t.index ["google_books_id"], name: "index_books_on_google_books_id", unique: true
  end

  create_table "character_relationships", force: :cascade do |t|
    t.bigint "source_character_id", null: false
    t.bigint "target_character_id", null: false
    t.string "relation", null: false
    t.string "source_to_target_impression"
    t.string "target_to_source_impression"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_character_id", "target_character_id"], name: "idx_on_source_character_id_target_character_id_61ef0dac88", unique: true
    t.index ["source_character_id"], name: "index_character_relationships_on_source_character_id"
    t.index ["target_character_id"], name: "index_character_relationships_on_target_character_id"
  end

  create_table "characters", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.integer "gender"
    t.integer "age"
    t.string "role"
    t.text "body", null: false
    t.bigint "incident_id"
    t.index ["incident_id"], name: "index_characters_on_incident_id"
  end

  create_table "incident_times", force: :cascade do |t|
    t.integer "year"
    t.integer "month"
    t.integer "date"
    t.integer "hour"
    t.integer "minute"
    t.integer "second"
    t.string "body", null: false
    t.integer "position"
    t.bigint "incident_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["incident_id"], name: "index_incident_times_on_incident_id"
  end

  create_table "incidents", force: :cascade do |t|
    t.string "name"
    t.integer "tag"
    t.text "body"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "book_id"
    t.index ["book_id"], name: "index_incidents_on_book_id"
    t.index ["user_id"], name: "index_incidents_on_user_id"
  end

  create_table "memos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tag", null: false
    t.text "body", null: false
    t.bigint "incident_id"
    t.index ["incident_id"], name: "index_memos_on_incident_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "character_relationships", "characters", column: "source_character_id"
  add_foreign_key "character_relationships", "characters", column: "target_character_id"
  add_foreign_key "characters", "incidents"
  add_foreign_key "incident_times", "incidents"
  add_foreign_key "incidents", "books"
  add_foreign_key "incidents", "users"
  add_foreign_key "memos", "incidents"
end
