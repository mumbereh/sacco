class CreateSavingsCommitments < ActiveRecord::Migration[7.2]
  def change
    create_table :savings_commitments do |t|
      t.references :member, null: false, foreign_key: true
      t.decimal :target_amount
      t.decimal :monthly_contribution
      t.string :status

      t.timestamps
    end
  end
end
