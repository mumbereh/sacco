class CreateAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :accounts do |t|
      t.references :member, null: false, foreign_key: true
      t.string :account_type
      t.decimal :balance

      t.timestamps
    end
  end
end
