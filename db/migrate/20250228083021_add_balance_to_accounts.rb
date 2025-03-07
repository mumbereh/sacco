class AddBalanceToAccounts < ActiveRecord::Migration[7.2]
  def change
    add_column :accounts, :balance, :decimal
  end
end
