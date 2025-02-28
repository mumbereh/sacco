class Loan < ApplicationRecord
  belongs_to :member

  REQUIRED_FIELDS = %i[amount interest_rate status loan_type].freeze

  validates :amount, numericality: { greater_than: 0, message: "must be greater than zero" }
  validates :interest_rate, numericality: { greater_than: 0, message: "must be a positive value" }
  validates :status, inclusion: { in: %w[pending approved rejected repaid], message: "must be a valid loan status" }
  validates :loan_type, inclusion: { in: ["Business Loan", "School Loan", "Land/House Purchase", "Salary Loan", "Emergency Loan", "Others"], message: "must be a valid loan type" }

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
