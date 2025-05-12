class LoanRepayment < ApplicationRecord
  belongs_to :loan
  belongs_to :member

  validates :payment_amount, numericality: { greater_than: 0, message: "must be a positive amount" }
  validates :payment_date, presence: true

  before_validation :set_due_date
  after_create :process_payment

  def set_due_date
    self.due_date ||= loan.try(:expected_payment_date) || (payment_date + 30.days rescue Date.today + 30.days)
  end

  def process_payment
    outstanding = loan.outstanding_balance

    if payment_amount > outstanding
      errors.add(:payment_amount, "exceeds the outstanding loan balance of UGX #{outstanding.to_i}")
      raise ActiveRecord::Rollback
    end

    # Penalty logic: 4-day grace period
    if payment_date > (due_date + 4.days)
      self.penalty_applied = true
      penalty_amount = (loan.interest_rate * payment_amount / 100).round
      self.payment_amount += penalty_amount
      save(validate: false)
    end

    loan.update_repayment_status
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
