class LoanRepayment < ApplicationRecord
  belongs_to :loan
  belongs_to :member

  validates :payment_amount, numericality: { greater_than: 0, message: "must be a positive amount" }
  validates :payment_date, presence: true

  after_create :process_payment

  def process_payment
    outstanding = loan.outstanding_balance

    if payment_amount > outstanding
      errors.add(:payment_amount, "exceeds the outstanding loan balance of UGX #{outstanding.to_i}")
      raise ActiveRecord::Rollback
    end

    # No need to update total_repaid — it's calculated dynamically

    # Update repayment status
    loan.update_repayment_status

    # Record this repayment as a transaction
    create_repayment_transaction
  end

  private

  def create_repayment_transaction
    account = member.account

    raise "Account not found for repayment" unless account

    # Ensure description is included in the transaction
    transaction = Transaction.create!(
      account: account,
      member: member,
      amount: payment_amount,
      transaction_type: "withdraw",
      description: "Loan repayment for loan ##{loan.id} on #{payment_date}"
    )
  end
end
