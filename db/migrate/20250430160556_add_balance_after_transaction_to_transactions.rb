class AddBalanceAfterTransactionToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :balance_after_transaction, :decimal
  end
end
