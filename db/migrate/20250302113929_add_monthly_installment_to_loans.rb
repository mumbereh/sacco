class AddMonthlyInstallmentToLoans < ActiveRecord::Migration[7.2]
  def change
    add_column :loans, :monthly_installment_payment, :decimal
  end
end
