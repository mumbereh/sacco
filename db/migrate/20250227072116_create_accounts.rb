class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.references :member, null: false, foreign_key: true
      t.string :account_type
      t.decimal :principal_amount
      t.decimal :deposit
      t.string :account_number

      t.timestamps
    end
    add_index :accounts, :account_number, unique: true
  end
end
