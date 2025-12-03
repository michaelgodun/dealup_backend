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

ActiveRecord::Schema[8.1].define(version: 2025_12_03_102044) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.bigint "deal_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["deal_id"], name: "index_comments_on_deal_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "deals", force: :cascade do |t|
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.datetime "end_date"
    t.decimal "original_price", precision: 10, scale: 2
    t.decimal "price", precision: 10, scale: 2, null: false
    t.datetime "start_date"
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.bigint "user_id", null: false
    t.integer "views", default: 0
    t.index ["user_id"], name: "index_deals_on_user_id"
  end

  create_table "exports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "format", null: false
    t.string "status", default: "pending"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_exports_on_user_id"
  end

  create_table "search_histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "query", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_search_histories_on_user_id"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.string "access_token"
    t.string "auth_protocol", default: "oauth2"
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.string "provider"
    t.string "provider_account_id"
    t.string "refresh_token"
    t.string "scope"
    t.string "token_type", default: "Bearer"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_user_accounts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "password_digest"
    t.string "refresh_token"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "deal_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "value"
    t.index ["deal_id"], name: "index_votes_on_deal_id"
    t.index ["user_id", "deal_id"], name: "index_votes_on_user_id_and_deal_id", unique: true
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "deals"
  add_foreign_key "comments", "users"
  add_foreign_key "deals", "users"
  add_foreign_key "exports", "users"
  add_foreign_key "search_histories", "users"
  add_foreign_key "user_accounts", "users"
  add_foreign_key "votes", "deals"
  add_foreign_key "votes", "users"
end
