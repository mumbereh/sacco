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

ActiveRecord::Schema[7.2].define(version: 2025_06_29_215651) do
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

  create_table "general_reports", force: :cascade do |t|
    t.decimal "total_deposits"
    t.decimal "total_withdrawals"
    t.decimal "total_transfers"
    t.decimal "cleared_loans"
    t.decimal "uncleared_loans"
    t.decimal "deposit_balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "individual_account_reports", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.decimal "total_deposits"
    t.decimal "total_withdrawals"
    t.decimal "total_transfers"
    t.decimal "total_loans"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_individual_account_reports_on_member_id"
  end

  create_table "loan_repayments", force: :cascade do |t|
    t.bigint "loan_id", null: false
    t.bigint "member_id", null: false
    t.decimal "payment_amount"
    t.date "payment_date"
    t.text "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "penalty_applied"
    t.date "due_date"
    t.index ["loan_id"], name: "index_loan_repayments_on_loan_id"
    t.index ["member_id"], name: "index_loan_repayments_on_member_id"
  end

  create_table "loan_reports", force: :cascade do |t|
    t.bigint "loan_id", null: false
    t.string "member_name"
    t.decimal "amount"
    t.decimal "interest_rate"
    t.decimal "total_amount_after_deduction"
    t.string "repayment_status"
    t.string "approval_status"
    t.string "status"
    t.decimal "total_repaid"
    t.decimal "outstanding_balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_loan_reports_on_loan_id"
  end

  create_table "loans", force: :cascade do |t|
    t.integer "member_id", null: false
    t.decimal "amount", null: false
    t.decimal "interest_rate", default: "3.0", null: false
    t.string "status", default: "pending", null: false
    t.string "loan_type", null: false
    t.decimal "monthly_installment_payment"
    t.integer "approval_status", default: 0, null: false
    t.integer "payment_period", null: false
    t.decimal "total_amount_after_deduction"
    t.date "date_loan_taken"
    t.date "date_loan_end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "loan_officer_approval"
    t.string "secretary_approval"
    t.string "chairperson_approval"
    t.string "repayment_status"
    t.boolean "secretary_approved"
    t.boolean "chairperson_approved"
  end

  create_table "loans_general_reports", force: :cascade do |t|
    t.string "member_name"
    t.string "account_number"
    t.decimal "cleared_loans"
    t.decimal "uncleared_loans"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "member_reports", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_member_reports_on_member_id"
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
    t.string "email"
    t.string "village"
    t.string "parish"
    t.string "subcounty"
    t.string "district"
    t.index ["email"], name: "index_members_on_email", unique: true
  end

  create_table "reports", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "report_type"
    t.string "reportable_type", null: false
    t.bigint "reportable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reportable_type", "reportable_id"], name: "index_reports_on_reportable"
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

  create_table "transaction_reports", force: :cascade do |t|
    t.date "from"
    t.date "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "member_id", null: false
    t.bigint "recipient_account_id"
    t.string "transaction_type"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "manual_recipient_account"
    t.decimal "balance_after_transaction"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["member_id"], name: "index_transactions_on_member_id"
    t.index ["recipient_account_id"], name: "index_transactions_on_recipient_account_id"
  end

  create_table "transactions_reports", force: :cascade do |t|
    t.date "from"
    t.date "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "members"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "individual_account_reports", "members"
  add_foreign_key "loan_repayments", "loans"
  add_foreign_key "loan_repayments", "members"
  add_foreign_key "loan_reports", "loans"
  add_foreign_key "loans", "members"
  add_foreign_key "member_reports", "members"
  add_foreign_key "savings_commitments", "members"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "accounts", column: "recipient_account_id"
  add_foreign_key "transactions", "members"
end
