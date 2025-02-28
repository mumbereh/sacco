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

ActiveRecord::Schema[7.2].define(version: 2025_02_28_083021) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.string "account_type"
    t.decimal "principal_amount"
    t.decimal "deposit"
    t.string "account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "balance"
    t.index ["account_number"], name: "index_accounts_on_account_number", unique: true
    t.index ["member_id"], name: "index_accounts_on_member_id"
  end

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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "loans", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.decimal "amount"
    t.decimal "interest_rate"
    t.string "status"
    t.string "loan_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_loans_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "membership_type"
    t.string "surname"
    t.string "given_name"
    t.string "other_name"
    t.date "date_of_birth"
    t.string "gender"
    t.string "marital_status"
    t.string "physical_address"
    t.string "phone"
    t.string "identification_type"
    t.string "id_number"
    t.string "mother_name"
    t.string "mother_nationality"
    t.string "father_name"
    t.string "father_nationality"
    t.string "kin_surname"
    t.string "kin_given_name"
    t.string "kin_other_name"
    t.date "kin_date_of_birth"
    t.string "kin_gender"
    t.string "kin_relationship"
    t.string "kin_phone"
    t.string "kin_address"
    t.string "declaration_name"
    t.string "signature"
    t.date "declaration_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "savings_commitments", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.decimal "target_amount"
    t.decimal "total_contributed"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_savings_commitments_on_member_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "member_id", null: false
    t.bigint "recipient_account_id"
    t.string "transaction_type"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["member_id"], name: "index_transactions_on_member_id"
    t.index ["recipient_account_id"], name: "index_transactions_on_recipient_account_id"
  end

  add_foreign_key "accounts", "members"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "loans", "members"
  add_foreign_key "savings_commitments", "members"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "accounts", column: "recipient_account_id"
  add_foreign_key "transactions", "members"
end
