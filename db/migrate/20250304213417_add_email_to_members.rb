class AddEmailToMembers < ActiveRecord::Migration[7.2]
  def change
    add_column :members, :email, :string
    add_index :members, :email, unique: true
  end
end
