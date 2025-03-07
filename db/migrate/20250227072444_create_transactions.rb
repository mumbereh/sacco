class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.references :account, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.references :recipient_account, foreign_key: { to_table: :accounts }
      t.string :transaction_type
      t.decimal :amount

      t.timestamps
    end
  end
end
