class AddLocationFieldsToMembers < ActiveRecord::Migration[7.2]
  def change
    add_column :members, :village, :string
    add_column :members, :parish, :string
    add_column :members, :subcounty, :string
    add_column :members, :district, :string
  end
end
