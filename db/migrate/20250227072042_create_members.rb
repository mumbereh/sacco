class CreateMembers < ActiveRecord::Migration[7.2]
  def change
    create_table :members do |t|
      t.string :membership_type
      t.string :surname
      t.string :given_name
      t.string :other_name
      t.date :date_of_birth
      t.string :gender
      t.string :marital_status
      t.string :physical_address
      t.string :phone
      t.string :identification_type
      t.string :id_number
      t.string :mother_name
      t.string :mother_nationality
      t.string :father_name
      t.string :father_nationality
      t.string :kin_surname
      t.string :kin_given_name
      t.string :kin_other_name
      t.date :kin_date_of_birth
      t.string :kin_gender
      t.string :kin_relationship
      t.string :kin_phone
      t.string :kin_address
      t.string :declaration_name
      t.string :signature
      t.date :declaration_date

      t.timestamps
    end
  end
end
