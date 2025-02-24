class Transaction < ApplicationRecord
  belongs_to :account
  after_create :update_balance

  def update_balance
    if transaction_type == "deposit"
      account.deposit(amount)
    elsif transaction_type == "withdrawal"
      account.withdraw(amount)
    end
  end
end
