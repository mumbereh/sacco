class LoanRepayment < ApplicationRecord
  belongs_to :loan
  belongs_to :member

  validates :payment_amount, numericality: { greater_than: 0, message: "must be a positive amount" }
  validates :payment_date, presence: true

  after_create :process_payment

  def process_payment
    outstanding = loan.total_amount_after_deduction - loan.total_repaid

    if payment_amount > outstanding
      errors.add(:payment_amount, "exceeds the outstanding loan balance of UGX #{outstanding}")
      raise ActiveRecord::Rollback
    end

    # Update loan repayment tracking
    loan.total_repaid ||= 0
    loan.total_repaid += payment_amount
    loan.save!  # Save the loan with updated total_repaid

    # Mark loan as fully repaid
    if loan.total_repaid >= loan.total_amount_after_deduction
      loan.update!(status: "repaid")
    end

    # Record this repayment as a transaction
    create_repayment_transaction
  end

  private

  def create_repayment_transaction
    account = member.account

    raise "Account not found for repayment" unless account

    Transaction.create!(
      account: account,
      member: member,
      amount: payment_amount,
      transaction_type: "withdraw",
      description: "Loan repayment for loan ##{loan.id} on #{payment_date}"
    )
  end
end
