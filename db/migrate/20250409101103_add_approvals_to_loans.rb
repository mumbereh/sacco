class AddApprovalsToLoans < ActiveRecord::Migration[7.2]
  def change
    add_column :loans, :loan_officer_approval, :string
    add_column :loans, :secretary_approval, :string
    add_column :loans, :chairperson_approval, :string
  end
end
