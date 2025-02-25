class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :member

  validates :transaction_type, inclusion: { in: ["deposit", "withdraw", "transfer"] }
  validates :amount, numericality: { greater_than: 0 }
  
  after_create :update_balance

  def update_balance
    case transaction_type
    when "deposit"
      account.update(balance: account.balance + amount)
    when "withdraw"
      if account.balance >= amount
        account.update(balance: account.balance - amount)
      else
        errors.add(:amount, "Insufficient funds")
        raise ActiveRecord::Rollback
      end
    end
  end
end
