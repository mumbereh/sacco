class AddTotalAmountAfterDeductionToLoans < ActiveRecord::Migration[7.2]
  def change
    add_column :loans, :total_amount_after_deduction, :decimal
  end
end
