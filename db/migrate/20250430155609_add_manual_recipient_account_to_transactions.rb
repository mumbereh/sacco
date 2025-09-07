class AddManualRecipientAccountToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :manual_recipient_account, :string
  end
end
