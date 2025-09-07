class CreateMemberReports < ActiveRecord::Migration[7.2]
  def change
    create_table :member_reports do |t|
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
