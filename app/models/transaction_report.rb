# == Model: TransactionReport
class TransactionReport < ApplicationRecord
  validates :from, :to, presence: true
  validate :date_range_valid

  def transactions
    Transaction.includes(:account, :member, :recipient_account)
               .where(created_at: from.beginning_of_day..to.end_of_day)
               .order(created_at: :desc)
  end

  private

  def date_range_valid
    if from.present? && to.present? && from > to
      errors.add(:to, "must be after start date")
    end
  end
end

# == Migration for transaction_reports
def change
  create_table :transaction_reports do |t|
    t.date :from, null: false
    t.date :to, null: false
    t.timestamps
  end
end
