class Loan < ApplicationRecord
  belongs_to :member

  validates :amount, numericality: { greater_than: 0 }
  validates :interest_rate, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w[pending approved rejected repaid] }

  def approve!
    update(status: "approved")
  end

  def reject!
    update(status: "rejected")
  end

  def repay(amount)
    if amount > 0 && amount <= self.amount
      update(amount: amount - amount)
      update(status: "repaid") if amount.zero?
    else
      errors.add(:amount, "Invalid repayment amount")
    end
  end
end
