class CreateTransactionReports < ActiveRecord::Migration[7.2]
  def change
    create_table :transaction_reports do |t|
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
