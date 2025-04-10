class AddApprovalFieldsToLoans < ActiveRecord::Migration[7.2]
  def change
    add_column :loans, :secretary_approved, :boolean
    add_column :loans, :chairperson_approved, :boolean
  end
end
