class AddPaymentPeriodToLoans < ActiveRecord::Migration[7.2]
  def change
    add_column :loans, :payment_period, :integer
  end
end
