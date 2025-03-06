class CreateLoanRepayments < ActiveRecord::Migration[7.2]
  def change
    create_table :loan_repayments do |t|
      t.references :loan, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.decimal :payment_amount
      t.date :payment_date
      t.text :note

      t.timestamps
    end
  end
end
