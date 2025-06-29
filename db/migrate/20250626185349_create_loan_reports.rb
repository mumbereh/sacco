class CreateLoanReports < ActiveRecord::Migration[7.2]
  def change
    create_table :loan_reports do |t|
      t.references :loan, null: false, foreign_key: true
      t.string :member_name
      t.decimal :amount
      t.decimal :interest_rate
      t.decimal :total_amount_after_deduction
      t.string :repayment_status
      t.string :approval_status
      t.string :status
      t.decimal :total_repaid
      t.decimal :outstanding_balance

      t.timestamps
    end
  end
end
