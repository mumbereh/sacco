class AddPersonalDetailsToMembers < ActiveRecord::Migration[7.2]
  def change
    add_column :members, :surname, :string
    add_column :members, :given_name, :string
    add_column :members, :other_name, :string
    add_column :members, :date_of_birth, :date
    add_column :members, :gender, :string
    add_column :members, :marital_status, :string
    add_column :members, :physical_address, :string
    add_column :members, :identification_type, :string
    add_column :members, :id_number, :string
    add_column :members, :mother_name, :string
    add_column :members, :mother_nationality, :string
    add_column :members, :father_name, :string
    add_column :members, :father_nationality, :string
    add_column :members, :kin_surname, :string
    add_column :members, :kin_given_name, :string
    add_column :members, :kin_other_name, :string
    add_column :members, :kin_date_of_birth, :date
    add_column :members, :kin_gender, :string
    add_column :members, :kin_relationship, :string
    add_column :members, :kin_phone, :string
    add_column :members, :kin_address, :string
    add_column :members, :declaration_name, :string
    add_column :members, :signature, :string
    add_column :members, :declaration_date, :date
  end
end
