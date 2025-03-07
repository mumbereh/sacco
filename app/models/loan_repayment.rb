class LoanRepayment < ApplicationRecord
  belongs_to :loan
  belongs_to :member


  validates :payment_amount, numericality: { greater_than: 0, message: "must be a positive amount" }
  validates :payment_date, presence: true

  def process_payment
    outstanding = loan.total_amount_after_deduction - loan.total_repaid
    if payment_amount > outstanding
      errors.add(:payment_amount, "exceeds the outstanding balance of the loan")
      return false
    else
      if (loan.total_repaid + payment_amount) >= loan.total_amount_after_deduction
        loan.update(status: "repaid")
      end
      return true
    end
  end
end
