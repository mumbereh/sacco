class Loan < ApplicationRecord
  belongs_to :member

  validates :amount, numericality: { greater_than: 0 }
  validates :interest_rate, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: %w[pending approved rejected repaid] }
  validates :loan_type, inclusion: { in: ["Business Loan", "School Loan", "Land/House purchase", "Salary Loan", "Emergency Loan", "Others"] }

  def approve!
    update(status: "approved")
  end

  def reject!
    update(status: "rejected")
  end

  def repay(payment_amount)
    if payment_amount.positive? && payment_amount <= amount
      update(amount: amount - payment_amount)
      update(status: "repaid") if amount.zero?
    else
      errors.add(:amount, "Invalid repayment amount")
    end
  end
end
