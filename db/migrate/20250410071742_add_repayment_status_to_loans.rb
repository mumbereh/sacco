class AddRepaymentStatusToLoans < ActiveRecord::Migration[7.2]
  def change
    add_column :loans, :repayment_status, :string
  end
end
