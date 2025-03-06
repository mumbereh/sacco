class CreateLoans < ActiveRecord::Migration[7.0]
  def change
    create_table :loans do |t|
      t.references :member, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.decimal :interest_rate, default: 3, null: false
      t.string :status, default: "pending", null: false
      t.string :loan_type, null: false
      t.decimal :monthly_installment_payment
      t.integer :approval_status, default: 0, null: false
      t.integer :payment_period, null: false
      t.decimal :total_amount_after_deduction

      t.date :date_loan_taken
      t.date :date_loan_end

      t.timestamps
    end
  end
end
