class Account < ApplicationRecord
  belongs_to :member
  has_many :transactions

  validates :account_type, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def deposit(amount)
    update(balance: balance + amount)
  end

  def withdraw(amount)
    if balance >= amount
      update(balance: balance - amount)
    else
      errors.add(:balance, "Insufficient funds")
    end
  end
end
